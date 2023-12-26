import 'dart:async';

import 'package:aev_sdk/aev_sdk.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:items_repository/items_repository.dart';
import 'package:logger/logger.dart';
import 'package:storages_repository/storages_repository.dart';

part 'inventory_state.dart';

class InventoryCubit extends Cubit<InventoryState> with LoggerMixin {
  InventoryCubit(this._repo) : super(const InventoryState.initial()) {
    _itemsRepoSubscription = _repo.listen((_, state) {
      // TODO(marco): add deleted and updated
      if (state is ItemsRepositoryItemLoadedSuccess ||
          state is ItemsRepositoryItemAddedSuccess) {
        _update(_repo.items);
      }
    });
  }

  final ItemsRepository _repo;

  late final StreamSubscription<ObservableEvent<ItemsRepositoryState>>
      _itemsRepoSubscription;

  void _update(List<ItemEntity> items) {
    emit(
      state.copyWith(
        items: items,
        groupItems: _groupItems(items),
        status: StateStatus.success,
      ),
    );
    logger.v('emitted: $state');
  }

  List<Object> _groupItems(List<ItemEntity> items) {
    final container = <DateTime, List<ItemEntity>>{};
    for (final item in items) {
      final itemExpDt = item.expirationDate;
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

  Future<void> onFetch() async {
    emit(state.copyWith(status: StateStatus.progress));
    try {
      await _repo.fetch();
      emit(
        state.copyWith(
          status: StateStatus.success,
          items: _repo.items,
          groupItems: _groupItems(_repo.items),
        ),
      );
    } catch (e, s) {
      logger.e(e.toString(), e, s);
      // FIXME: add exception message
      emit(state.copyWithError(e.toString()));
    }
  }

  void applyFilter(StorageEntity? storage) {
    if (storage == null) {
      // returns all items
      emit(
        state.copyWith(
          items: _repo.items,
          groupItems: _groupItems(_repo.items),
        ),
      );
    } else {
      final filteredItems = _repo.items
          .where((item) => item.storage.uuid == storage.uuid)
          .toList();
      emit(
        state.copyWith(
          items: [...filteredItems],
          groupItems: _groupItems(filteredItems),
        ),
      );
    }
  }

  @override
  Future<void> close() {
    _itemsRepoSubscription.cancel().ignore();
    return super.close();
  }
}
