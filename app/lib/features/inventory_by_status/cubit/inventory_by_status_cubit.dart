import 'dart:async';

import 'package:aev_sdk/aev_sdk.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:items_repository/items_repository.dart';
import 'package:storages_repository/storages_repository.dart';

part 'inventory_by_status_state.dart';

class InventoryByStatusCubit extends Cubit<InventoryByStatusState> {
  InventoryByStatusCubit(
    this._repo, {
    required ItemsStatus filter,
  }) : super(InventoryByStatusState.initial(filter)) {
    _update(
      _repo.items,
      sortItems: false,
    );
    _itemsRepoSubscription = _repo.listen((previousState, state) {
      if (state is ItemsRepositoryItemDeletedSuccess ||
          state is ItemsRepositoryItemFullConsumedSuccess ||
          state is ItemsRepositoryItemUpdatedSuccess) {
        final updatedItemDateTime =
            state is ItemsRepositoryItemUpdatedSuccess &&
                state.prevItem.expirationDate != state.item.expirationDate;
        final openedOrClosedItem = state is ItemsRepositoryItemUpdatedSuccess &&
            state.prevItem.openedAt != state.item.openedAt;
        final sortItems =
            state is ItemsRepositoryItemDeletedSuccess || updatedItemDateTime;
        if (state is! ItemsRepositoryItemUpdatedSuccess ||
            updatedItemDateTime ||
            openedOrClosedItem) {
          _update(
            _repo.items,
            sortItems: sortItems,
          );
        }
      }
    });
  }

  final ItemsRepository _repo;

  late final StreamSubscription<ObservableEvent<ItemsRepositoryState>>
      _itemsRepoSubscription;

  bool _filter(ItemEntity item) {
    if (state.filter == ItemsStatus.opened) {
      // TODO: use item.isOpened
      return item.openedAt != null &&
          !item.expirationDate.toDate().isBefore(
                DateTime.now().toDate(),
              );
    } else if (state.filter == ItemsStatus.expired) {
      // TODO: use item.isExpired
      return item.expirationDate.toDate().isBefore(
            DateTime.now().toDate(),
          );
    }
    final remainingDays =
        item.expirationDate.toDate().difference(DateTime.now().toDate()).inDays;
    // TODO: defines a const variable inside item entity. When an item should be
    // eaten soon? Max in 2 days?
    return remainingDays >= 0 && remainingDays < 3;
  }

  void _update(
    List<ItemEntity> items, {
    required bool sortItems,
  }) {
    late final List<ItemEntity> sortedItems;
    if (sortItems) {
      sortedItems = [
        ...items.where(_filter).sortedBy((element) => element.expirationDate),
      ];
    } else {
      sortedItems = [...items.where(_filter)];
    }
    emit(
      state.copyWith(
        items: sortedItems,
        groupItems: _groupItems(sortedItems),
      ),
    );
  }

  List<Object> _groupItems(List<ItemEntity> items) {
    final container = <DateTime, List<ItemEntity>>{};
    for (final item in items) {
      final itemExpDt =
          state.filter.isOpened ? item.openedAt! : item.expirationDate;
      final dt = DateTime.utc(
        itemExpDt.year,
        itemExpDt.month,
        itemExpDt.day,
      );
      if (!container.containsKey(dt)) {
        container[dt] = [];
      }
      container[dt]!.add(item);
    }
    final flattenItems = <Object>[];
    var containsExpDt = false;
    for (final dt in container.keys) {
      // Adds the exp date first and then the items related to the date.
      // The exp date is added only if the exp date is not before today or
      // if no exp date before tpday is already in the list.
      if (!(dt.toDate().isBefore(DateTime.now().toDate()) && containsExpDt)) {
        flattenItems.add(dt);
      }
      flattenItems.addAll(container[dt]!);
      if (dt.toDate().isBefore(DateTime.now().toDate())) {
        containsExpDt = true;
      }
    }
    return flattenItems;
  }

  @override
  Future<void> close() {
    _itemsRepoSubscription.cancel().ignore();
    return super.close();
  }
}
