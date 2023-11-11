part of 'storages_cubit.dart';

final class StoragesState extends SuperBlocState {
  const StoragesState._({
    required this.storages,
    required super.status,
    super.errorMessage,
  });

  StoragesState.initial()
      : storages = [],
        super.initial();

  final List<StorageEntity> storages;

  @override
  StoragesState copyWith({
    StateStatus? status,
    List<StorageEntity>? storages,
  }) {
    return StoragesState._(
      storages: storages ?? this.storages,
      status: status ?? this.status,
    );
  }

  @override
  StoragesState copyWithError(String errorMessage) {
    return StoragesState._(
      storages: storages,
      status: status,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [storages, status, errorMessage];
}
