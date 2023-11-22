import 'package:get_it/get_it.dart';
import 'package:products_repository/products_repository.dart';
import 'package:storages_repository/storages_repository.dart';

import '../../../items_repository.dart';

abstract class ItemsRepository
    extends CrudRepository<ItemEntity, ItemsRepositoryState> {
  static ItemsRepository get I => GetIt.I.get<ItemsRepository>();

  Future<void> fetch();

  Future<ItemEntity> upsert({
    required ProductEntity product,
    required DateTime expirationDate,
    required Measure remainingMeasure,
    required StorageEntity storage,
    String? id,
    int? shelf,
  });

  // delete
  Future<bool> delete(String id);
}
