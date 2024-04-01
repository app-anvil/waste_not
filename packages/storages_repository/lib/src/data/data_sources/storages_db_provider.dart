import 'package:a2f_sdk/a2f_sdk.dart';
import 'package:uuid/uuid.dart';

import '../../../storages_repository.dart';

class StoragesDbProvider implements StoragesProvider {
  StoragesDbProvider(this._dbService);

  final IsarService _dbService;

  @override
  Future<StorageModel> add({
    required String name,
    required StorageType type,
    required double orderingPriority,
    String? description,
  }) async {
    final isar = await _dbService.db;
    final uuid = const Uuid().v4();
    final storage = StorageDbModel(
      uuid: uuid,
      storageType: type,
      name: name,
      orderingPriority: orderingPriority,
      description: description,
    );
    isar.writeTxnSync(() => isar.storageDbModels.putSync(storage));
    return StorageModel(
      uuid: uuid,
      name: name,
      storageType: type,
      description: description,
      orderingPriority: orderingPriority,
    );
  }

  @override
  Future<bool> delete(String id) async {
    final isar = await _dbService.db;
    return isar.writeTxn(
      () async => isar.storageDbModels.where().uuidEqualTo(id).deleteFirst(),
    );
  }

  @override
  Future<StorageModel> update({
    required String id,
    required String name,
    required StorageType type,
    required double orderingPriority,
    String? description,
  }) async {
    final isar = await _dbService.db;

    return isar.writeTxn(() async {
      final storage =
          await isar.storageDbModels.where().uuidEqualTo(id).findFirst();

      if (storage == null) {
        throw AssertionError('Storage must exist');
      }

      final updatedStorage = storage.copyWith(
        name: name,
        description: description,
        storageType: type,
        orderingPriority: orderingPriority,
      );

      await isar.storageDbModels.put(updatedStorage);

      return updatedStorage;
    });
  }

  @override
  Future<List<StorageModel>> fetch() async {
    final isar = await _dbService.db;
    return await isar.storageDbModels.where().sortByOrderingPriority().findAll()
      ..map((e) => e.toModel());
  }
}
