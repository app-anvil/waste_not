import 'dart:async';

import 'package:a2f_sdk/a2f_sdk.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:items_repository/items_repository.dart';
import 'package:storages_repository/storages_repository.dart';

part 'item_state.dart';

class ItemCubit extends Cubit<ItemState> with LoggerMixin {
  ItemCubit({
    required ItemsRepository repo,
    required ItemEntity item,
  })  : _repo = repo,
        super(ItemState.initial(item)) {
    _itemsRepoSubscription = _repo.listen((_, repoState) {
      if (repoState is ItemsRepositoryItemUpdatedSuccess) {
        // if the expiration date is not the same, the inventory bloc updates
        // the items list, so it is not necessary to update this cubit state.
        if (repoState.item.uuid == state.item.uuid &&
            repoState.item.expirationDate ==
                repoState.prevItem.expirationDate &&
            repoState.item.openedAt == repoState.prevItem.openedAt) {
          _update(repoState.item);
        }
      }
    });
  }

  final ItemsRepository _repo;

  late final StreamSubscription<ObservableEvent<ItemsRepositoryState>>
      _itemsRepoSubscription;

  void _update(ItemEntity newItem) {
    emit(state.copyWith(status: StateStatus.success, item: newItem));
  }

  Future<void> onOpened() async {
    // emit(state.copyWith(status: StateStatus.progress));
    try {
      final item = state.item;
      await _repo.upsert(
        product: item.product,
        expirationDate: item.expirationDate,
        remainingMeasure: item.remainingMeasure,
        storage: item.storage,
        id: item.uuid,
        openedAt: state.item.openedAt == null ? DateTime.now() : null,
      );
      emit(
        state.copyWith(
          status: StateStatus.success,
        ),
      );
    } catch (e, s) {
      logger.e(e.toString(), e, s);
      // FIXME: add exception message
      emit(state.copyWithError(e.toString()));
    }
  }

  @override
  Future<void> close() {
    logger.v('Item cubit with id: ${state.item.uuid} is closing ...');
    _itemsRepoSubscription.cancel().ignore();
    return super.close();
  }
}
