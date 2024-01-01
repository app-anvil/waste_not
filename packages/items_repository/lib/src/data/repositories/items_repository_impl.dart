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
    required DateTime expirationDate,
    required Measure remainingMeasure,
    required StorageEntity storage,
    required DateTime? openedAt,
    String? id,
    int? shelf,
  }) async {
    // check if an item exists or exist an item with some, product (barcode),
    // same expiration date: in these case perform an update.
    // else the item should be added.
    var prevItem = items.firstWhereOrNull(
      (element) =>
          element.product.barcode == product.barcode &&
          element.expirationDate == expirationDate,
    );
    if (id != null || prevItem != null) {
      late final ItemModel updatedItem;
      if (id != null) {
        logger.v('Updating item with id: $id...');
        prevItem ??= getItemOrThrow(id);
        updatedItem = await _provider.update(
          id: id,
          expirationDate: expirationDate,
          remainingMeasure: remainingMeasure,
          storage: storage,
          openedAt: openedAt,
          shelf: shelf,
        );
      } else {
        logger.v(
          'Updating item with product with barcode: ${product.barcode}...',
        );
        updatedItem = await _provider.update(
          id: prevItem!.uuid,
          expirationDate: expirationDate,
          remainingMeasure: remainingMeasure,
          storage: storage,
          openedAt: openedAt,
          shelf: shelf,
        );
      }
      _itemsMap[updatedItem.uuid] = updatedItem;
      logger.d('Item updated successfully: $prevItem, $updatedItem');
      emit(ItemsRepositoryItemUpdatedSuccess(prevItem, updatedItem));
      return updatedItem;
    } else {
      logger.v('Creating new item...');
      final item = await _provider.add(
        product: product,
        expirationDate: expirationDate,
        remainingMeasure: remainingMeasure,
        storage: storage,
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
    required double quantity,
  }) async {
    final prevItem = getItemOrThrow(id);
    if (prevItem.remainingMeasure.quantity == quantity) {
      // full consume
      await _provider.delete(id);
      _itemsMap.remove(id);
      logger.d('$prevItem full consumed successfully');
      emit(ItemsRepositoryItemFullConsumedSuccess(prevItem));
    } else {
      final updatedItem = await _provider.update(
        id: id,
        expirationDate: prevItem.expirationDate,
        remainingMeasure: Measure(
          quantity: quantity,
          unitOfMeasure: UnitOfMeasure.unit,
        ),
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
}
