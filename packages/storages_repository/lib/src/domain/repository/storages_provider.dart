import 'package:storages_repository/storages_repository.dart';

abstract interface class StoragesProvider {
  Future<StorageModel> add({
    required String name,
    required StorageType type,
    required double orderingPriority,
    String? description,
  });

  Future<StorageModel> update({
    required String id,
    required String name,
    required StorageType type,
    required double orderingPriority,
    String? description,
  });

  /// Fetchs the storages sorted by ordering priority in ascending order.
  Future<List<StorageModel>> fetch();

  Future<bool> delete(String id);
}
