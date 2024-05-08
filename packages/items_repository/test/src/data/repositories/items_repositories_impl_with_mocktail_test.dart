import 'package:flutter_test/flutter_test.dart';
import 'package:items_repository/items_repository.dart';
import 'package:mocktail/mocktail.dart';
import 'package:products_repository/products_repository.dart';
import 'package:storages_repository/storages_repository.dart';

class MockItemsProvider extends Mock implements ItemsProvider {}

class MockStorage extends Mock implements StorageEntity {}

class MockProduct extends Mock implements ProductEntity {}

void main() {
  late MockItemsProvider mockItemsProvider;
  late ItemsRepositoryImpl itemsRepoImpl;
  late ItemModel item;

  final createdAt = DateTime.now().subtract(const Duration(days: 3));
  final openedAt = DateTime.now();

  final product = MockProduct();

  final pantry = MockStorage();

  setUp(() async {
    item = PantryItemModel(
      uuid: '0',
      product: product,
      initialExpiryDate: DateTime(2023, 12, 12),
      createdAt: createdAt,
      storage: pantry,
      amount: 5,
    );

    mockItemsProvider = MockItemsProvider();
    itemsRepoImpl = ItemsRepositoryImpl(mockItemsProvider);

    registerFallbackValue(MockStorage());
    registerFallbackValue(MockProduct());
  });

  test('Add new item', () async {
    // arrange
    when<Future<ItemEntity>>(
      () => mockItemsProvider.add(
        product: product,
        initialExpiryDate: DateTime(2023, 12, 12),
        amount: 5,
        storage: pantry,
        openedAt: null,
      ),
    ).thenAnswer((invocation) async => item);

    // excecute
    await itemsRepoImpl.upsert(
      product: product,
      initialExpiryDate: DateTime(2023, 12, 12),
      amount: 5,
      storage: pantry,
      openedAt: null,
    );

    // verify
    expect(itemsRepoImpl.items.length, 1);
    expect(itemsRepoImpl.items.first.amount, 5);
  });

  group('Open an item', () {
    final openedItem = PantryItemModel(
      uuid: '1',
      product: product,
      initialExpiryDate: DateTime(2023, 12, 12),
      createdAt: createdAt,
      openedAt: openedAt,
      storage: pantry,
      amount: 1,
    );

    test('Open an item with amount greater than 1', () async {
      final items = [item, openedItem];
      // arrange
      // the first time adds the original item the second one adds the
      // opened item
      when<Future<ItemEntity>>(
        () => mockItemsProvider.add(
          initialExpiryDate: any(named: 'initialExpiryDate'),
          amount: any(named: 'amount'),
          storage: any(named: 'storage'),
          openedAt: any(named: 'openedAt'),
          product: any(named: 'product'),
        ),
      ).thenAnswer((invocation) async => items.removeAt(0));

      // updated existing item
      when<Future<ItemEntity>>(
        () => mockItemsProvider.update(
          id: item.uuid,
          initialExpiryDate: DateTime(2023, 12, 12),
          amount: 4,
          storage: pantry,
          openedAt: null,
        ),
      ).thenAnswer((_) async => item);

      final id = item.uuid;

      await itemsRepoImpl.upsert(
        product: product,
        initialExpiryDate: DateTime(2023, 12, 12),
        amount: 5,
        storage: pantry,
        openedAt: null,
      );

      await itemsRepoImpl.open(id: id);

      expect(itemsRepoImpl.items.length, 2);
      expect(itemsRepoImpl.items.first.amount, 5);
      expect(itemsRepoImpl.items.last.amount, 1);
    });

    test('Open an item with amount equal to 1', () async {
      final originalItem = PantryItemModel(
        uuid: '0',
        product: product,
        initialExpiryDate: DateTime(2023, 12, 12),
        createdAt: createdAt,
        storage: pantry,
        amount: 1,
      );

      final items = [originalItem, openedItem];
      // arrange
      // the first time adds the original item the second one adds the
      // opened item
      when<Future<ItemEntity>>(
        () => mockItemsProvider.add(
          initialExpiryDate: any(named: 'initialExpiryDate'),
          amount: any(named: 'amount'),
          storage: any(named: 'storage'),
          openedAt: any(named: 'openedAt'),
          product: any(named: 'product'),
        ),
      ).thenAnswer((invocation) async => items.removeAt(0));

      // delete the item
      when<Future<bool>>(
        () => mockItemsProvider.delete('0'),
      ).thenAnswer((_) async => true);

      final id = item.uuid;

      await itemsRepoImpl.upsert(
        product: product,
        initialExpiryDate: DateTime(2023, 12, 12),
        amount: 5,
        storage: pantry,
        openedAt: null,
      );

      await itemsRepoImpl.open(id: id);

      expect(itemsRepoImpl.items.length, 1);
    });
  });

  group('Unopen an item', () {
    final fridge = StorageModel(
      uuid: '0',
      name: 'Fridge',
      storageType: StorageType.fridge,
      orderingPriority: 2,
    );

    final openedPantryItem = PantryItemModel(
      uuid: '2',
      product: product,
      initialExpiryDate: DateTime(2023, 12, 12),
      createdAt: createdAt,
      openedAt: openedAt,
      storage: pantry,
      amount: 1,
    );

    final pantryItem = PantryItemModel(
      uuid: '1',
      product: product,
      initialExpiryDate: DateTime(2023, 12, 12),
      createdAt: createdAt,
      openedAt: null,
      storage: pantry,
      amount: 4,
    );

    final openedShelfItem = ShelfItemModel(
      uuid: '2',
      product: product,
      initialExpiryDate: DateTime(2023, 12, 12),
      createdAt: createdAt,
      openedAt: openedAt,
      storage: fridge,
      amount: 1,
      shelf: 3,
    );

    final shelfItem = ShelfItemModel(
      uuid: '1',
      product: product,
      initialExpiryDate: DateTime(2023, 12, 12),
      createdAt: createdAt,
      openedAt: null,
      storage: fridge,
      amount: 4,
      shelf: 3,
    );

    test('Unopen a mergable pantry item', () async {
      // exists an closed item equal to the the that shoulb be un open.
      // So in items initially have two items, after the unopen action there
      // will be only one item.

      final itemsAdded = [pantryItem, openedPantryItem];

      // arrange
      // the first time adds the original item the second one adds the
      // opened item
      when<Future<ItemEntity>>(
        () => mockItemsProvider.add(
          initialExpiryDate: any(named: 'initialExpiryDate'),
          amount: any(named: 'amount'),
          storage: any(named: 'storage'),
          openedAt: any(named: 'openedAt'),
          product: any(named: 'product'),
        ),
      ).thenAnswer((invocation) async => itemsAdded.removeAt(0));

      // updated existing item
      when<Future<ItemEntity>>(
        () => mockItemsProvider.update(
          id: pantryItem.uuid,
          initialExpiryDate: DateTime(2023, 12, 12),
          amount: 5,
          storage: pantry,
          openedAt: null,
        ),
      ).thenAnswer((_) async => pantryItem);

      // delete the item
      when<Future<bool>>(
        () => mockItemsProvider.delete(any()),
      ).thenAnswer((_) async => true);

      final id = openedPantryItem.uuid;

      // add new item
      await itemsRepoImpl.upsert(
        product: product,
        initialExpiryDate: DateTime(2023, 12, 12),
        amount: 4,
        storage: pantry,
        openedAt: null,
      );

      // add an opened item
      await itemsRepoImpl.upsert(
        product: product,
        initialExpiryDate: DateTime(2023, 12, 12),
        amount: 1,
        storage: pantry,
        openedAt: openedAt,
      );

      expect(itemsRepoImpl.items.length, 2);

      await itemsRepoImpl.unOpen(id: id);

      expect(itemsRepoImpl.items.length, 1);
    });

    test('Unopen a mergable shelf item', () async {
      // exists an closed item equal to the the that shoulb be un open.
      // So in items initially have two items, after the unopen action there
      // will be only one item.

      final itemsAdded = [shelfItem, openedShelfItem];

      // arrange
      // the first time adds the original item the second one adds the
      // opened item
      when<Future<ItemEntity>>(
        () => mockItemsProvider.add(
          initialExpiryDate: any(named: 'initialExpiryDate'),
          amount: any(named: 'amount'),
          storage: any(named: 'storage'),
          openedAt: any(named: 'openedAt'),
          product: any(named: 'product'),
          shelf: any(named: 'shelf'),
        ),
      ).thenAnswer((invocation) async => itemsAdded.removeAt(0));

      // updated existing item
      when<Future<ItemEntity>>(
        () => mockItemsProvider.update(
          id: shelfItem.uuid,
          initialExpiryDate: DateTime(2023, 12, 12),
          amount: 5,
          storage: fridge,
          openedAt: null,
          shelf: 3,
        ),
      ).thenAnswer((_) async => shelfItem);

      // delete the item
      when<Future<bool>>(
        () => mockItemsProvider.delete(any()),
      ).thenAnswer((_) async => true);

      final id = openedShelfItem.uuid;

      // add new item
      await itemsRepoImpl.upsert(
        product: product,
        initialExpiryDate: DateTime(2023, 12, 12),
        amount: 4,
        storage: fridge,
        openedAt: null,
        shelf: 3,
      );

      // add an opened item
      await itemsRepoImpl.upsert(
        product: product,
        initialExpiryDate: DateTime(2023, 12, 12),
        amount: 1,
        storage: fridge,
        openedAt: openedAt,
        shelf: 3,
      );

      expect(itemsRepoImpl.items.length, 2);

      await itemsRepoImpl.unOpen(id: id);

      expect(itemsRepoImpl.items.length, 1);
    });
  });
}
