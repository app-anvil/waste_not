import 'package:a2f_sdk/a2f_sdk.dart';
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
    required DateTime initialExpiryDate,
    required int amount,
    required StorageEntity storage,
    required DateTime? openedAt,
    String? id,
    int? shelf,
  });

  /// The [amount] indicates how many items with [id] user has consumed.
  Future<void> consume({
    required String id,
    required int amount,
  });

  /// Opens the item with [id].
  ///
  /// It creates a new item equal to the item with [id] with openedAt
  /// field equal to now.
  Future<void> open({required String id});

  /// Closes the opened item with [id].
  ///
  /// It deletes the item with [id] and increase by +1 an existing item
  /// with same value or create a new one.
  Future<void> unOpen({required String id});

  // delete
  Future<bool> delete(String id);

  // TODO: add maybeGetById
}
