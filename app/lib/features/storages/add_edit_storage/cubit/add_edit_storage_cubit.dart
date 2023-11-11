import 'package:app/core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:storages_repository/storages_repository.dart';

part 'add_edit_storage_state.dart';

class AddEditStorageCubit extends Cubit<AddEditStorageState> with LoggerMixin {
  AddEditStorageCubit({
    required StoragesRepository repo,
    this.initialStorage,
  })  : _repo = repo,
        super(AddEditStorageState.initial(initialStorage));

  final StorageEntity? initialStorage;

  final StoragesRepository _repo;

  // FIXME: use form field builder to show specific error
  Future<void> onSave() async {
    if (!state.isValid) {
      emit(state.copyWithError('Storage name must not be empty'));
      return;
    }
    emit(state.copyWith(status: StateStatus.progress));
    try {
      if (initialStorage != null) {
        await _repo.update(
          // or initialStorage.id
          id: state.id!,
          name: state.name.value,
          type: state.storageType,
          description: state.description,
          // This value is directly put from the initial storage,
          // because the state does not handle ordering priority.
          orderingPriority: initialStorage!.orderingPriority,
        );
      } else {
        await _repo.add(
          name: state.name.value,
          type: state.storageType,
          description: state.description,
        );
      }
      emit(state.copyWith(status: StateStatus.success));
    } catch (e, s) {
      logger.e(e.toString(), e, s);
      emit(state.copyWithError(e.toString()));
    }
  }

  void onNameChanged(String value) => emit(
        state.copyWith(
          name: RequiredField.dirty(value),
        ),
      );

  void onDescriptionChanged(String value) => emit(
        state.copyWith(description: Optional(value.isNotEmpty ? value : null)),
      );

  void onStorageTypeChanged(StorageType type) => emit(
        state.copyWith(storageType: type),
      );
}
