part of 'storages_cubit.dart';

final class StoragesState extends SuperBlocState {
  const StoragesState._({
    required this.storages,
    required super.status,
    super.errorMessage,
  });

  const StoragesState.initial()
      : storages = const [],
        super.initial();

  final List<s.StorageEntity> storages;

  @override
  StoragesState copyWith({
    StateStatus? status,
    List<s.StorageEntity>? storages,
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
      status: StateStatus.failure,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [storages, ...super.props];
}
