import 'dart:async';

import 'package:a2f_sdk/a2f_sdk.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:items_repository/items_repository.dart';
import 'package:storages_repository/storages_repository.dart';

part 'filter_items_state.dart';

class FilterItemsCubit extends Cubit<FilterItemsState> {
  FilterItemsCubit(this._repo) : super(const FilterItemsState.initial()) {
    // If there is an active storage filter, the new item can be not visible to
    // the user because can insert in a different storage, so we reset the state
    /// of the cubit.
    _itemsRepoSubscription = _repo.listen((_, repoState) {
      if (repoState is ItemsRepositoryItemAddedSuccess) {
        if (state.selectedStorage != null) _reset();
      }
    });
  }

  final ItemsRepository _repo;

  late final StreamSubscription<ObservableEvent<ItemsRepositoryState>>
      _itemsRepoSubscription;

  void _reset() {
    emit(const FilterItemsState.initial());
  }

  void onToggled(StorageEntity storage) {
    if (state.selectedStorage == storage) {
      emit(
        state.copyWith(
          selectedStorage: const Optional(null),
        ),
      );
    } else {
      emit(
        state.copyWith(
          selectedStorage: Optional(storage),
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
