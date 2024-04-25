import 'package:collection/collection.dart';
import 'package:products_repository/products_repository.dart';
import 'package:storages_repository/storages_repository.dart';

import '../../../items_repository.dart';

class ItemsRepositoryImpl extends ItemsRepository {
  ItemsRepositoryImpl(this._provider);

  final ItemsProvider _provider;

  /// Internal map of items.
  ///
  /// Keys are the items' uuids.
  Map<String, ItemModel> _itemsMap = {};

  /// Gets the item in the repository by [id] if currently loaded in the
  /// repository.
  ///
  /// If the item is not present in the repository (regardless if it exists
  /// or not) null is returned instead.
  ItemModel? getStorage(String id) => _itemsMap[id];

  @override
  ItemModel getItemOrThrow(String id) =>
      getStorage(id) ??
      (throw StateError(
        '$ItemModel $id not found in the repository',
      ));

  @override
  Future<void> fetch() async {
    logger.v('Fetching items ...');
    final tempMap = {..._itemsMap};
    final items = await _provider.fetch();
    for (final item in items) {
      tempMap[item.uuid] = item;
      // TODO: ask, is it useful? Is ItemsRepositoryItemsLoadedSuccess enough?
      emit(ItemsRepositoryItemLoadedSuccess(item));
    }
    logger.d('${items.length} $ItemEntity(s) fetched');
    _itemsMap = tempMap;
  }

  @override
  Future<ItemModel> upsert({
    required ProductEntity product,
    required DateTime initialExpiryDate,
    required int amount,
    required StorageEntity storage,
    required DateTime? openedAt,
    String? id,
    int? shelf,
  }) async {
    // check if an item exists
    if (id != null) {
      late final ItemModel updatedItem;
      late final ItemModel prevItem;

      logger.v('Updating item with id: $id...');
      prevItem = getItemOrThrow(id);
      updatedItem = await _provider.update(
        id: id,
        initialExpiryDate: initialExpiryDate,
        amount: amount,
        storage: storage,
        openedAt: openedAt,
        shelf: shelf,
      );

      _itemsMap[updatedItem.uuid] = updatedItem;
      logger.d('Item updated successfully: $prevItem, $updatedItem');
      emit(ItemsRepositoryItemUpdatedSuccess(prevItem, updatedItem));
      return updatedItem;
    } else {
      logger.v('Creating new item...');
      final item = await _provider.add(
        product: product,
        initialExpiryDate: initialExpiryDate,
        amount: amount,
        storage: storage,
        openedAt: openedAt,
        shelf: shelf,
      );
      _itemsMap[item.uuid] = item;
      logger.v('$item created successfully in the repository...');
      emit(ItemsRepositoryItemAddedSuccess(item));
      return item;
    }
  }

  @override
  Future<bool> delete(String id) async {
    logger.v('Deleting item with id=$id...');
    final item = getItemOrThrow(id);
    final deleted = await _provider.delete(id);
    _itemsMap.remove(id);
    logger.d('$item deleted successfully');
    emit(ItemsRepositoryItemDeletedSuccess(item));
    return deleted;
  }

  @override
  ItemsRepositoryState get initialState => ItemsRepositoryInitial();

  @override
  List<ItemModel> get items => [..._itemsMap.values];

  @override
  Future<void> consume({
    required String id,
    required int amount,
  }) async {
    final prevItem = getItemOrThrow(id);
    if (prevItem.amount == amount) {
      // full consume
      await _provider.delete(id);
      _itemsMap.remove(id);
      logger.d('$prevItem full consumed successfully');
      emit(ItemsRepositoryItemFullConsumedSuccess(prevItem));
    } else {
      final updatedItem = await _provider.update(
        id: id,
        initialExpiryDate: prevItem.initialExpiryDate,
        amount: amount,
        storage: prevItem.storage,
        openedAt: prevItem.openedAt,
        shelf: prevItem is ShelfItemEntity
            ? (prevItem as ShelfItemEntity).shelf
            : null,
      );
      _itemsMap[updatedItem.uuid] = updatedItem;
      logger.d('Item partially consumed successfully: $prevItem, $updatedItem');
      emit(ItemsRepositoryItemUpdatedSuccess(prevItem, updatedItem));
    }
  }

  @override
  Future<void> open({required String id}) async {
    final item = getItemOrThrow(id);
    // create a new opened item with amount 1.
    final openedItem = await _provider.add(
      initialExpiryDate: item.initialExpiryDate,
      amount: 1,
      storage: item.storage,
      openedAt: DateTime.now(),
      product: item.product,
      shelf: item is ShelfItemEntity ? (item as ShelfItemEntity).shelf : null,
    );
    _itemsMap[openedItem.uuid] = openedItem;
    // decrese the item amount by 1 or delete it.
    if (item.amount > 1) {
      final updatedItem = await _provider.update(
        id: id,
        initialExpiryDate: item.initialExpiryDate,
        amount: item.amount - 1,
        storage: item.storage,
        openedAt: null,
        shelf: item is ShelfItemEntity ? (item as ShelfItemEntity).shelf : null,
      );
      _itemsMap[updatedItem.uuid] = updatedItem;
    } else {
      await _provider.delete(id);
      _itemsMap.remove(id);
    }
    logger.d('Item opened successfully: $openedItem');
    emit(ItemsRepositoryItemOpenedSuccess(openedItem));
    emit(ItemsRepositoryUpdatedSuccess(items));
  }

  @override
  Future<void> unOpen({required String id}) async {
    final item = getItemOrThrow(id);

    final sameItem = items.firstWhereOrNull(
      (i) => i.shouldBeMergedWith(item),
    );
    await _provider.delete(id);
    _itemsMap.remove(id);
    if (sameItem != null) {
      final updatedItem = await _provider.update(
        id: sameItem.uuid,
        initialExpiryDate: sameItem.initialExpiryDate,
        amount: sameItem.amount + 1,
        storage: sameItem.storage,
        openedAt: null,
        shelf: sameItem is ShelfItemEntity
            ? (sameItem as ShelfItemEntity).shelf
            : null,
      );
      _itemsMap[updatedItem.uuid] = updatedItem;
    } else {
      final newItem = await _provider.add(
        initialExpiryDate: item.initialExpiryDate,
        amount: 1,
        storage: item.storage,
        openedAt: null,
        product: item.product,
        shelf: item is ShelfItemEntity ? (item as ShelfItemEntity).shelf : null,
      );
      _itemsMap[newItem.uuid] = newItem;
      logger.d('Item unopened successfully: $newItem');
      emit(ItemsRepositoryItemUnOpenedSuccess(newItem));
    }
    emit(ItemsRepositoryUpdatedSuccess(items));
  }
}
