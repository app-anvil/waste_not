import 'package:aev_sdk/aev_sdk.dart';
import '../../../storages_repository.dart';

sealed class StoragesRepositoryState extends Equatable {
  const StoragesRepositoryState();

  @override
  bool? get stringify => false;
}

class StoragesRepositoryInitial extends StoragesRepositoryState {
  @override
  List<Object?> get props => [];
}

class StoragesRepositoryStorageAddedSuccess extends StoragesRepositoryState {
  const StoragesRepositoryStorageAddedSuccess(this.storage);

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

class StoragesRepositoryStorageUpdatedSuccess extends StoragesRepositoryState {
  const StoragesRepositoryStorageUpdatedSuccess(this.prevstorage, this.storage);

  final StorageEntity prevstorage;

  final StorageEntity storage;

  @override
  List<Object?> get props => [prevstorage, storage];
}

class StoragesRepositoryStorageDeletedSuccess extends StoragesRepositoryState {
  @override
  List<Object?> get props => [];
}

class StoragesRepositoryUpdatedSuccess extends StoragesRepositoryState {
  const StoragesRepositoryUpdatedSuccess(this.storages);
  final List<StorageEntity> storages;

  @override
  List<Object?> get props => [storages];
}
