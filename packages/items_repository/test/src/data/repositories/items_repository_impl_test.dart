import 'package:flutter_test/flutter_test.dart';
import 'package:items_repository/items_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:storages_repository/storages_repository.dart';

import '../models/models_test.dart';
import 'items_repository_impl_test.mocks.dart';

@GenerateMocks([ItemsProvider])
void main() {
  late MockItemsProvider mockItemsProvider;
  late ItemsRepositoryImpl itemsRepoImpl;
  late ItemModel item;

  final createdAt = DateTime.now().subtract(const Duration(days: 3));
  final openedAt = DateTime.now();

  final product = MockProduct();

  final pantry = StorageModel(
    uuid: '0',
    name: 'Pantry',
    storageType: StorageType.pantry,
    orderingPriority: 1,
  );

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
  });

  test('Add new item', () async {
    // arrange
    when<Future<ItemEntity>>(
      mockItemsProvider.add(
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
      //arrange
      // the first time adds the original item the second one adds the
      // opened item
      when<Future<ItemEntity>>(
        mockItemsProvider.add(
          initialExpiryDate: anyNamed('initialExpiryDate'),
          amount: anyNamed('amount'),
          storage: anyNamed('storage'),
          openedAt: anyNamed('openedAt'),
          product: anyNamed('product'),
        ),
      ).thenAnswer((invocation) async => items.removeAt(0));

      // updated existing item
      when<Future<ItemEntity>>(
        mockItemsProvider.update(
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
      //arrange
      // the first time adds the original item the second one adds the
      // opened item
      when<Future<ItemEntity>>(
        mockItemsProvider.add(
          initialExpiryDate: anyNamed('initialExpiryDate'),
          amount: anyNamed('amount'),
          storage: anyNamed('storage'),
          openedAt: anyNamed('openedAt'),
          product: anyNamed('product'),
        ),
      ).thenAnswer((invocation) async => items.removeAt(0));

      // delete the item
      when<Future<bool>>(
        mockItemsProvider.delete('0'),
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
}
