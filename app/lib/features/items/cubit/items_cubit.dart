import 'dart:async';

import 'package:aev_sdk/aev_sdk.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:items_repository/items_repository.dart';
import 'package:logger/logger.dart';
import 'package:storages_repository/storages_repository.dart';

part 'items_state.dart';

class ItemsCubit extends Cubit<ItemsState> with LoggerMixin {
  ItemsCubit(this._repo) : super(const ItemsState.initial()) {
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
        status: StateStatus.success,
      ),
    );
    logger.v('emitted: $state');
  }

  Future<void> onFetch() async {
    emit(state.copyWith(status: StateStatus.progress));
    try {
      await _repo.fetch();
      emit(
        state.copyWith(
          status: StateStatus.success,
          items: _repo.items,
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
    _itemsRepoSubscription.cancel().ignore();
    return super.close();
  }
}
