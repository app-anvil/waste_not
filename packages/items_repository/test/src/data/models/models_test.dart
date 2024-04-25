import 'package:flutter_test/flutter_test.dart';
import 'package:items_repository/items_repository.dart';
import 'package:mocktail/mocktail.dart';
import 'package:products_repository/products_repository.dart';
import 'package:storages_repository/storages_repository.dart';

class MockProduct extends Mock implements ProductEntity {}

void main() {
  final product = MockProduct();
  final pantry = StorageModel(
    uuid: '0',
    name: 'Pantry',
    storageType: StorageType.pantry,
    orderingPriority: 1,
  );
  final fridge = StorageModel(
    uuid: '0',
    name: 'Fridge',
    storageType: StorageType.fridge,
    orderingPriority: 2,
  );
  final freezer = StorageModel(
    uuid: '0',
    name: 'Freezer',
    storageType: StorageType.freezer,
    orderingPriority: 3,
  );
  final pantryItem = PantryItemModel(
    uuid: '0',
    product: product,
    initialExpiryDate: DateTime(2023, 12, 12),
    createdAt: DateTime.now(),
    storage: pantry,
    amount: 1,
  );

  final fridgeItem = ShelfItemModel(
    uuid: '1',
    product: product,
    initialExpiryDate: DateTime(2023, 12, 12),
    createdAt: DateTime.now(),
    storage: fridge,
    amount: 4,
  );

  final freezerItem = ShelfItemModel(
    uuid: '1',
    product: product,
    initialExpiryDate: DateTime(2023, 12, 12),
    createdAt: DateTime.now(),
    storage: freezer,
    amount: 1,
  );

  setUp(() {});

  test('PantryItemModel is a subclass of ItemEntity', () {
    expect(pantryItem, isA<ItemEntity>());
  });

  test('PantryItemModel is a subclass of ItemModel', () {
    expect(fridgeItem, isA<ItemModel>());
  });

  test('FridgeItemModel is a subclass of ItemEntity', () {
    expect(fridgeItem, isA<ItemEntity>());
  });

  test('FridgeItemModel is a subclass of ShelfItemEntityI', () {
    expect(fridgeItem, isA<ShelfItemEntity>());
  });

  test('FridgeItemModel is a subclass of ItemModel', () {
    expect(fridgeItem, isA<ItemModel>());
  });

  test('FreezerItemModel is a subclass of ItemEntity', () {
    expect(freezerItem, isA<ItemEntity>());
  });

  test('FreezerItemModel is a subclass of ShelfItemEntityI', () {
    expect(freezerItem, isA<ShelfItemEntity>());
  });
}
