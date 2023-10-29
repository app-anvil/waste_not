import 'package:flutter_test/flutter_test.dart';
import 'package:items_repository/items_repository.dart';
import 'package:mocktail/mocktail.dart';
import 'package:products_repository/products_repository.dart';

class MockProduct extends Mock implements ProductEntity {}

void main() {
  final product = MockProduct();
  final pantryItem = PantryItemModel(
    id: '0',
    product: product,
    expirationDate: DateTime(2023, 12, 12),
    createdAt: DateTime.now(),
    remainingMeasure: Measure(
      quantity: 1,
      unitOfMeasure: UnitOfMeasure.unit,
    ),
    storage: DefaultStorages.pantry,
  );

  final fridgeItem = ShelfItemModel(
    id: '1',
    product: product,
    expirationDate: DateTime(2023, 12, 12),
    createdAt: DateTime.now(),
    remainingMeasure: Measure(
      quantity: 1,
      unitOfMeasure: UnitOfMeasure.unit,
    ),
    storage: DefaultStorages.fridge,
  );

  final freezerItem = ShelfItemModel(
    id: '1',
    product: product,
    expirationDate: DateTime(2023, 12, 12),
    createdAt: DateTime.now(),
    remainingMeasure: Measure(
      quantity: 1,
      unitOfMeasure: UnitOfMeasure.unit,
    ),
    storage: DefaultStorages.freezer,
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
