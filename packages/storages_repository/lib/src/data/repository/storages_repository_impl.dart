import 'dart:async';

import 'package:collection/collection.dart';
import '../../../storages_repository.dart';

class StoragesRepositoryImpl extends StoragesRepository {
  StoragesRepositoryImpl(this._provider);

  static const int orderingPriorityFactor = 100;

  final StoragesProvider _provider;

  /// Internal map of storages.
  ///
  /// Keys are the storages' uuids.

  /// Internal list of storages.
  List<StorageModel> _storages = <StorageModel>[];

  /// Exposes the list of [StorageModel]s contained in this repository.
  ///
  /// The list is not sorted.
  @override
  List<StorageModel> get items => [..._storages];

  /// Gets a moment in the repository by [id] if currently loaded in the
  /// repository.
  ///
  /// If the storage is not present in the repository (regardless if it exists
  /// or not) null is returned instead.
  StorageModel? getStorage(String id) =>
      _storages.firstWhereOrNull((s) => s.uuid == id);

  @override
  StorageModel getItemOrThrow(String id) =>
      getStorage(id) ??
      (throw StateError(
        '$StorageModel $id not found in the repository',
      ));

  @override
  Future<void> add({
    required String name,
    required StorageType type,
    String? description,
  }) async {
    logger.v('Creating new storage...');
    final orderingPriority =
        _storages.last.orderingPriority + orderingPriorityFactor;
    final storage = await _provider.add(
      name: name,
      type: type,
      description: description,
      orderingPriority: orderingPriority,
    );
    //_storagesMap[storage.uuid] = storage;
    _storages.add(storage);
    logger.v('$storage created successfully in the repository...');
    emit(StoragesRepositoryStorageAddedSuccess(storage));
  }

  @override
  Future<bool> delete(String id) async {
    logger.v('Deleting storage with id=$id...');
    final storage = getItemOrThrow(id);
    final deleted = await _provider.delete(id);
    //_storagesMap.remove(id);
    _storages.remove(storage);
    logger.d('$storage deleted successfully');
    emit(StoragesRepositoryStorageDeletedSuccess());
    return deleted;
  }

  @override
  Future<StorageModel> update({
    required String id,
    required String name,
    required StorageType type,
    required double orderingPriority,
    String? description,
  }) async {
    logger.v('Updating storage with id: $id...');
    final storage = getItemOrThrow(id);
    final updatedObject = await _provider.update(
      id: id,
      name: name,
      type: type,
      description: description,
      orderingPriority: orderingPriority,
    );
    //_storagesMap[updatedObject.uuid] = updatedObject;
    _storages[_storages.indexWhere((element) => element.uuid == id)] =
        updatedObject;
    logger.d('Storage updated successfully');
    emit(StoragesRepositoryStorageUpdatedSuccess(storage, updatedObject));
    return updatedObject;
  }

  @override
  Future<void> fetch() async {
    logger.v('Fetching storages ...');
    //final tempMap = {..._storagesMap};
    final storages = await _provider.fetch();
    // for (final storage in storages) {
    //   tempMap[storage.uuid] = storage;
    //   emit(StoragesRepositoryLoadedSuccess(storage));
    // }
    logger.d('${storages.length} $StorageEntity(s) fetched');
    //_storagesMap = tempMap;
    // It is necessary to cast the list otherwise with a direct assignment,
    // the runtype of _storages becomes CastList<StorageBdModel>.
    _storages = [...storages];
    emit(StoragesRepositoryUpdatedSuccess(_storages));
  }

  /// Gets the orderingPriority for a storage given the value of the
  /// [newIndex] that is the index where the caller wants to put a new
  /// note.
  double _getOrderingPriorityForIndex(int newIndex) {
    if (_storages.isEmpty) return 0;
    if (newIndex <= 0) {
      return _storages.first.orderingPriority - orderingPriorityFactor;
    }
    if (newIndex >= _storages.length) {
      return _storages.last.orderingPriority + orderingPriorityFactor;
    }
    final prevPriority = _storages[newIndex - 1].orderingPriority;
    final nextPriority = _storages[newIndex].orderingPriority;
    return (prevPriority + nextPriority) / 2;
  }

  /// This function can be unawaited and not throwing any exceptions.
  @override
  Future<void> reorder({
    required int oldIndex,
    required int newIndex,
  }) async {
    final movedStorage = _storages[oldIndex];
    _storages.remove(movedStorage);
    final newPriority = _getOrderingPriorityForIndex(newIndex);
    final updatedStorage = await _provider.update(
      id: movedStorage.uuid,
      name: movedStorage.name,
      type: movedStorage.storageType,
      orderingPriority: newPriority,
    );
    // insert the value in the new index position
    if (newIndex < _storages.length) {
      _storages.insert(newIndex, updatedStorage);
    } else {
      _storages.add(updatedStorage);
    }
    emit(StoragesRepositoryUpdatedSuccess(items));
  }

  @override
  StoragesRepositoryState get initialState => StoragesRepositoryInitial();
}
