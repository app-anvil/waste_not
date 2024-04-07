import 'package:products_repository/products_repository.dart';
import 'package:storages_repository/storages_repository.dart';

import '../../../items_repository.dart';

abstract interface class ItemsProvider {
  /// Most of the time an item is added with openedAt equal to null.
  ///
  /// Use [openedAt] when an opened item is deleted from the db and the
  /// user wants to undo the operation. So a new item is created and [openedAt]
  /// field should be set.
  Future<ItemModel> add({
    required ProductEntity product,
    required DateTime initialExpiryDate,
    required int amount,
    required StorageEntity storage,
    required DateTime? openedAt,
    int? shelf,
    int? unsealedLifeTimeInDays,
  });

  Future<ItemModel> update({
    required String id,
    required DateTime initialExpiryDate,
    required int amount,
    required StorageEntity storage,
    required DateTime? openedAt,
    int? shelf,
    int? unsealedLifeTimeInDays,
  });

  /// Fetchs the storages sorted by ordering priority in ascending order.
  Future<List<ItemModel>> fetch();

  Future<bool> delete(String id);
}
