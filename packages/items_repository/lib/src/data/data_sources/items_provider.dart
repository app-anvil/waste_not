import 'package:products_repository/products_repository.dart';
import 'package:storages_repository/storages_repository.dart';

import '../../../items_repository.dart';

abstract interface class ItemsProvider {
  Future<ItemModel> add({
    required ProductEntity product,
    required DateTime expirationDate,
    required Measure remainingMeasure,
    required StorageEntity storage,
    int? shelf,
  });

  Future<ItemModel> update({
    required String id,
    required DateTime expirationDate,
    required Measure remainingMeasure,
    required StorageEntity storage,
    int? shelf,
  });

  /// Fetchs the storages sorted by ordering priority in ascending order.
  Future<List<ItemModel>> fetch();

  Future<bool> delete(String id);
}
