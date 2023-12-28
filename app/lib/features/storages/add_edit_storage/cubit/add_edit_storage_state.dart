part of 'add_edit_storage_cubit.dart';

final class AddEditStorageState extends SuperBlocState {
  const AddEditStorageState._({
    required super.status,
    required this.storageType,
    required this.name,
    this.id,
    this.description,
    super.errorMessage,
  });
  AddEditStorageState.initial(StorageEntity? storage)
      : name = storage?.name != null
            ? RequiredField.dirty(storage!.name)
            : const RequiredField.pure(),
        description = storage?.description,
        storageType = storage?.storageType ?? StorageType.pantry,
        id = storage?.uuid,
        super.initial();

  final String? id;
  final RequiredField name;
  final String? description;
  final StorageType storageType;

  bool get isValid => name.isValid;

  @override
  AddEditStorageState copyWith({
    StateStatus? status,
    RequiredField? name,
    Optional<String?> description = const Optional.absent(),
    StorageType? storageType,
  }) {
    return AddEditStorageState._(
      status: status ?? this.status,
      id: id,
      name: name ?? this.name,
      description: description.orElseIfAbsent(this.description),
      storageType: storageType ?? this.storageType,
    );
  }

  @override
  AddEditStorageState copyWithError(String errorMessage) {
    return AddEditStorageState._(
      status: StateStatus.failure,
      id: id,
      name: name,
      description: description,
      storageType: storageType,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        storageType,
        ...super.props,
      ];

  @override
  bool? get stringify => true;
}
