import 'package:items_repository/items_repository.dart';

class DefaultStorages {
  static final fridge = Storage(
    id: '0',
    name: 'Fridge',
    storageType: StorageType.fridge,
  );

  static final freezer = Storage(
    id: '1',
    name: 'Freezer',
    storageType: StorageType.freezer,
  );

  static final pantry = Storage(
    id: '2',
    name: 'Pantry',
    storageType: StorageType.pantry,
  );

  static final values = [freezer, fridge, pantry];
}

class Storage {
  Storage({
    required this.id,
    required this.name,
    required this.storageType,
    this.description,
  });

  final String id;
  final String name;
  final String? description;
  final StorageType storageType;
}
