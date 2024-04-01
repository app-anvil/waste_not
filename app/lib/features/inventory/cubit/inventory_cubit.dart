import 'dart:async';

import 'package:a2f_sdk/a2f_sdk.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:items_repository/items_repository.dart';
import 'package:storages_repository/storages_repository.dart';

part 'inventory_state.dart';

class InventoryCubit extends Cubit<InventoryState> with LoggerMixin {
  InventoryCubit(this._repo) : super(const InventoryState.initial()) {
    _itemsRepoSubscription = _repo.listen((_, state) {
      if (state is ItemsRepositoryItemLoadedSuccess ||
          state is ItemsRepositoryItemAddedSuccess ||
          state is ItemsRepositoryItemDeletedSuccess ||
          state is ItemsRepositoryItemFullConsumedSuccess ||
          state is ItemsRepositoryItemUpdatedSuccess) {
        final updatedItemDateTime =
            state is ItemsRepositoryItemUpdatedSuccess &&
                state.prevItem.expirationDate != state.item.expirationDate;
        final openedOrClosedItem = state is ItemsRepositoryItemUpdatedSuccess &&
            state.prevItem.openedAt != state.item.openedAt;
        final sortItems = state is ItemsRepositoryItemAddedSuccess ||
            state is ItemsRepositoryItemDeletedSuccess ||
            updatedItemDateTime;
        // it does not monitor the updating of items's remainingMeasure and
        // storage because each item's tile has already rebuilding by its cubit
        // if any of these changes happened.
        final updatesUI = state is! ItemsRepositoryItemUpdatedSuccess ||
            updatedItemDateTime ||
            openedOrClosedItem;

        _update(
          _repo.items,
          deletedItem:
              state is ItemsRepositoryItemDeletedSuccess ? state.item : null,
          fullConsumedItem: state is ItemsRepositoryItemFullConsumedSuccess
              ? state.item
              : null,
          sortItems: sortItems,
          updatesUI: updatesUI,
        );
      }
    });
  }

  final ItemsRepository _repo;

  late final StreamSubscription<ObservableEvent<ItemsRepositoryState>>
      _itemsRepoSubscription;

  /// Item is not opened or it is expired.
  bool _filter(ItemEntity item) {
    return !item.status.isOpened || item.status.isExpired;
  }

  /// Emit only not opened items.
  void _update(
    List<ItemEntity> items, {
    required ItemEntity? deletedItem,
    required ItemEntity? fullConsumedItem,
    required bool sortItems,
    required bool updatesUI,
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
        lastItemDeleted: Optional(deletedItem),
        lastItemFullConsumed: Optional(fullConsumedItem),
        status: StateStatus.success,
        updatesUI: updatesUI,
      ),
    );
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
      // if no exp date before today is already in the list.
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
      final notOpenedItems = [
        ..._repo.items.where(_filter),
      ];
      emit(
        state.copyWith(
          status: StateStatus.success,
          items: notOpenedItems,
          groupItems: _groupItems(notOpenedItems),
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
      final notOpenedItems = [
        ..._repo.items.where(_filter),
      ];
      emit(
        state.copyWith(
          items: notOpenedItems,
          groupItems: _groupItems(notOpenedItems),
          status: StateStatus.success,
        ),
      );
    } else {
      final filteredItems = [
        ..._repo.items.where(
          (item) => _filter(item) && item.storage.uuid == storage.uuid,
        ),
      ];
      emit(
        state.copyWith(
          items: filteredItems,
          groupItems: _groupItems(filteredItems),
          status: StateStatus.success,
        ),
      );
    }
  }

  Future<void> onFullConsume(String id) async {
    emit(state.copyWith(status: StateStatus.progress));
    try {
      final item = _repo.getItemOrThrow(id);
      await _repo.consume(
        quantity: item.remainingMeasure.quantity,
        id: item.uuid,
      );
      // No need to emit state
    } catch (e, s) {
      logger.e(e.toString(), e, s);
      // FIXME: add exception message
      emit(state.copyWithError(e.toString()));
    }
  }

  Future<void> onDelete(String id) async {
    try {
      await _repo.delete(id);
      // No need to emit state because the the subscription is in charge of
      // listen the state of the repo and emit a new bloc'state.
    } catch (e, s) {
      logger.e(e.toString(), e, s);
      emit(state.copyWithError(e.toString()));
    }
  }

  Future<void> onUndoDeletionItemRequested() async {
    assert(
      state.lastItemDeleted != null,
      'Last deleted item can not be null.',
    );

    final item = state.lastItemDeleted!;
    emit(
      state.copyWith(
        lastItemDeleted: const Optional(null),
        status: StateStatus.success,
      ),
    );
    await _repo.upsert(
      product: item.product,
      expirationDate: item.expirationDate,
      remainingMeasure: item.remainingMeasure,
      storage: item.storage,
      openedAt: item.openedAt,
      // create a new item, with different uuid.
      //id: item.uuid,
      shelf: item is ShelfItemEntity ? item.shelf : null,
    );
  }

  Future<void> onUndoFullConsumptionItemRequested() async {
    assert(
      state.lastItemFullConsumed != null,
      'Last full consumed item can not be null.',
    );

    final item = state.lastItemFullConsumed!;
    emit(
      state.copyWith(
        lastItemFullConsumed: const Optional(null),
        status: StateStatus.success,
      ),
    );
    await _repo.upsert(
      product: item.product,
      expirationDate: item.expirationDate,
      remainingMeasure: item.remainingMeasure,
      storage: item.storage,
      openedAt: item.openedAt,
      // create a new item, with different uuid.
      //id: item.uuid,
      shelf: item is ShelfItemEntity ? item.shelf : null,
    );
  }

  @override
  Future<void> close() {
    _itemsRepoSubscription.cancel().ignore();
    return super.close();
  }
}
