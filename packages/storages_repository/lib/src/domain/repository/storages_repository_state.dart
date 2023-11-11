import 'package:common_components/common_components.dart';
import 'package:storages_repository/storages_repository.dart';

sealed class StoragesRepositoryState extends Equatable {
  const StoragesRepositoryState();
}

class StoragesRepositoryInitial extends StoragesRepositoryState {
  @override
  List<Object?> get props => [];
}

class StoragesRepositoryStorageAddSuccess extends StoragesRepositoryState {
  const StoragesRepositoryStorageAddSuccess(this.storage);

  final StorageEntity storage;

  @override
  List<Object?> get props => [storage];
}

class StoragesRepositoryLoadedSuccess extends StoragesRepositoryState {
  const StoragesRepositoryLoadedSuccess(this.storage);

  final StorageEntity storage;

  @override
  List<Object?> get props => [storage];
}

class StoragesRepositoryStorageUpdateSuccess extends StoragesRepositoryState {
  const StoragesRepositoryStorageUpdateSuccess(this.prevstorage, this.storage);

  final StorageEntity prevstorage;

  final StorageEntity storage;

  @override
  List<Object?> get props => [prevstorage, storage];
}

class StoragesRepositoryStorageDeleteSuccess extends StoragesRepositoryState {
  @override
  List<Object?> get props => [];
}

class StoragesRepositoryUpdateSuccess extends StoragesRepositoryState {
  const StoragesRepositoryUpdateSuccess(this.storages);
  final List<StorageEntity> storages;

  @override
  List<Object?> get props => [storages];
}
