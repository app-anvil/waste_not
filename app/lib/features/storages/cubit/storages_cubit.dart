import 'dart:async';

import 'package:a2f_sdk/a2f_sdk.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storages_repository/storages_repository.dart' as s;

part 'storages_state.dart';

class StoragesCubit extends Cubit<StoragesState> with LoggerMixin {
  StoragesCubit(this._repo) : super(const StoragesState.initial()) {
    _storagesRepoSubscription = _repo.listen((_, state) {
      if (state is! s.StoragesRepositoryInitial) {
        _update(_repo.items);
      }
    });

    // _storagesRepoSubscription2 = _repo.states.listen((state) {
    //   print('_storagesRepoSubscription2: $state');
    //   if (state.state is! StoragesRepositoryInitial) {
    //     _update(_repo.storages);
    //   }
    // });
  }

  final s.StoragesRepository _repo;

  late final StreamSubscription<ObservableEvent<s.StoragesRepositoryState>>
      _storagesRepoSubscription;

  void _update(List<s.StorageEntity> storages) {
    emit(
      state.copyWith(storages: storages, status: StateStatus.success),
    );
  }

  Future<void> onDelete(String id) async {
    emit(state.copyWith(status: StateStatus.progress));
    try {
      await _repo.delete(id);
      emit(state.copyWith(status: StateStatus.success));
    } catch (e, s) {
      logger.e(e.toString(), e, s);
      emit(state.copyWithError(e.toString()));
    }
  }

  /// Fetches the storages from the [s.StoragesRepository].
  Future<void> onFetch() async {
    emit(state.copyWith(status: StateStatus.progress));
    try {
      await _repo.fetch();
      emit(
        state.copyWith(
          status: StateStatus.success,
          storages: _repo.items,
        ),
      );
    } catch (e, s) {
      logger.e(e.toString(), e, s);
      emit(state.copyWithError(e.toString()));
    }
  }

  Future<void> onReorder(int oldIndex, int newIndex) async {
    // reorder the list and update
    unawaited(_repo.reorder(oldIndex: oldIndex, newIndex: newIndex));
  }

  @override
  Future<void> close() {
    _storagesRepoSubscription.cancel().ignore();
    return super.close();
  }
}
