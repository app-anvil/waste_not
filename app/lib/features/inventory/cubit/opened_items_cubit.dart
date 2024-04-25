import 'dart:async';

import 'package:a2f_sdk/a2f_sdk.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:items_repository/items_repository.dart';
import 'package:storages_repository/storages_repository.dart' as s;

import '../../features.dart';

part 'opened_items_state.dart';

class OpenedItemsCubit extends Cubit<OpenedItemsState> {
  OpenedItemsCubit(this._repo) : super(const OpenedItemsState.initial()) {
    _itemsRepoSubscription = _repo.listen((_, state) {
      final openedItem = state is ItemsRepositoryItemOpenedSuccess;
      final closedItem = state is ItemsRepositoryItemUnOpenedSuccess;
      // when an opened item is restored (undo action) a new item with same
      // values is added.
      final openedItemRestored = state is ItemsRepositoryItemAddedSuccess &&
          ItemStatus.fromItem(state.item).isOpened;
      if (state is ItemsRepositoryItemLoadedSuccess ||
          openedItem ||
          closedItem ||
          state is ItemsRepositoryItemDeletedSuccess ||
          state is ItemsRepositoryItemFullConsumedSuccess ||
          openedItemRestored) {
        _update(
          _repo.items,
          sortItems: false,
        );
      }
    });
  }

  final ItemsRepository _repo;

  late final StreamSubscription<ObservableEvent<ItemsRepositoryState>>
      _itemsRepoSubscription;

  /// Item is opened but it is not expired yet.
  bool _filter(ItemEntity item) {
    return ItemStatus.fromItem(item).isOpened &&
        !ItemStatus.fromItem(item).isExpired;
  }

  /// Emit only opened items.
  void _update(
    List<ItemEntity> items, {
    required bool sortItems,
  }) {
    late final List<ItemEntity> sortedItems;
    if (sortItems) {
      sortedItems = [
        ...items.where(_filter).sortedBy((element) => element.openedAt!),
      ];
    } else {
      sortedItems = [...items.where(_filter)];
    }
    emit(
      state.copyWith(
        items: sortedItems,
      ),
    );
  }

  void applyFilter(s.StorageEntity? storage) {
    if (storage == null) {
      // returns all items
      final openedItems = [
        ..._repo.items.where(_filter),
      ];
      emit(
        state.copyWith(
          items: openedItems,
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
