import 'package:a2f_sdk/a2f_sdk.dart';
import 'package:products_repository/products_repository.dart';
import 'package:storages_repository/storages_repository.dart';
import 'package:uuid/uuid.dart';

import '../../../items_repository.dart';

class ItemsDbProvider implements ItemsProvider {
  ItemsDbProvider(this._dbService);

  final IsarService _dbService;

  @override
  Future<ItemModel> add({
    required ProductEntity product,
    required DateTime initialExpiryDate,
    required int amount,
    required StorageEntity storage,
    required DateTime? openedAt,
    int? shelf,
    int? unsealedLifeTimeInDays,
  }) async {
    final isar = await _dbService.db;
    final uuid = const Uuid().v4();
    final createdAt = DateTime.now();
    // create link to the storage

    final storageDb = await isar.storageDbModels
        .where()
        .uuidEqualTo(storage.uuid)
        .findFirst();

    final item = ItemIsarModel()
      ..initialExpiryDate = initialExpiryDate
      ..createdAt = createdAt
      ..shelf = shelf
      ..product = ProductIsar.fromEntity(product)
      ..storage.value = storageDb
      ..openedAt = openedAt
      ..amount = amount
      ..unsealedLifeTimeInDays = unsealedLifeTimeInDays
      ..uuid = uuid;

    await isar.writeTxn(() async {
      await isar.itemIsarModels.put(item);
      await item.storage.save();
    });

    return item.toModel();
  }

  @override
  Future<bool> delete(String id) async {
    final isar = await _dbService.db;
    return isar.writeTxn(
      () async => isar.itemIsarModels.where().uuidEqualTo(id).deleteFirst(),
    );
  }

  @override
  Future<List<ItemModel>> fetch() async {
    final isar = await _dbService.db;
    final items =
        await isar.itemIsarModels.where().sortByInitialExpiryDate().findAll();
    return items.map((e) => e.toModel()).toList();
  }

  @override
  Future<ItemModel> update({
    required String id,
    required DateTime initialExpiryDate,
    required int amount,
    required StorageEntity storage,
    required DateTime? openedAt,
    int? shelf,
    int? unsealedLifeTimeInDays,
  }) async {
    final isar = await _dbService.db;

    return isar.writeTxn(() async {
      final item =
          await isar.itemIsarModels.where().uuidEqualTo(id).findFirst();

      if (item == null) {
        throw AssertionError('Item must exist');
      }

      final storageDb = await isar.storageDbModels
          .where()
          .uuidEqualTo(storage.uuid)
          .findFirst();

      final updatedItem = item.copyWith(
        initialExpiryDate: initialExpiryDate,
        amount: amount,
        storage: storageDb,
        shelf: shelf,
        openedAt: openedAt != null ? Optional(openedAt) : const Optional(null),
        unsealedLifeTimeInDays: unsealedLifeTimeInDays,
      );

      await isar.itemIsarModels.put(updatedItem);
      await item.storage.save();

      return updatedItem.toModel();
    });
  }
}
