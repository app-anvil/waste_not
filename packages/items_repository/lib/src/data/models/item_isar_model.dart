import 'package:a2f_sdk/a2f_sdk.dart';
import 'package:products_repository/products_repository.dart';
import 'package:storages_repository/storages_repository.dart';

import '../../../items_repository.dart';

part 'item_isar_model.g.dart';

@Collection(ignore: {'copyWith'})
class ItemIsarModel {
  Id id = Isar.autoIncrement;

  @Index()
  late String uuid;

  late DateTime initialExpiryDate;

  late DateTime createdAt;

  late ProductIsar product;

  final storage = IsarLink<StorageDbModel>();

  late int? shelf;

  late DateTime? openedAt;

  late int amount;

  late int? unsealedLifeTimeInDays;

  ItemIsarModel copyWith({
    DateTime? initialExpiryDate,
    StorageDbModel? storage,
    Optional<DateTime?> openedAt = const Optional.absent(),
    int? shelf,
    int? amount,
    int? unsealedLifeTimeInDays,
  }) {
    return ItemIsarModel()
      ..id = id
      ..uuid = uuid
      ..createdAt = createdAt
      ..product = product
      ..shelf = shelf ?? this.shelf
      ..storage.value = storage ?? this.storage.value
      ..initialExpiryDate = initialExpiryDate ?? this.initialExpiryDate
      ..openedAt = openedAt.orElseIfAbsent(this.openedAt)
      ..unsealedLifeTimeInDays =
          unsealedLifeTimeInDays ?? this.unsealedLifeTimeInDays
      ..amount = amount ?? this.amount;
  }

  ItemModel toModel() {
    if (storage.value == null) {
      throw Exception('No storage is linked');
    }
    final productModel = ProductModel(
      id: product.id,
      barcode: product.barcode,
      name: product.name,
      imageFrontUrl: product.imageFrontUrl,
      imageFrontSmallUrl: product.imageFrontSmallUrl,
    );
    if (storage.value?.storageType == StorageType.pantry) {
      return PantryItemModel(
        uuid: uuid,
        initialExpiryDate: initialExpiryDate,
        createdAt: createdAt,
        openedAt: openedAt,
        storage: storage.value!,
        product: productModel,
        amount: amount,
        unsealedLifeTimeInDays: unsealedLifeTimeInDays,
      );
    }
    return ShelfItemModel(
      uuid: uuid,
      initialExpiryDate: initialExpiryDate,
      createdAt: createdAt,
      openedAt: openedAt,
      storage: storage.value!,
      product: productModel,
      // check value of null on isar
      shelf: shelf,
      amount: amount,
      unsealedLifeTimeInDays: unsealedLifeTimeInDays,
    );
  }
}

@embedded
class ProductIsar {
  ProductIsar();

  ProductIsar.fromEntity(ProductEntity product)
      : id = product.id ?? product.barcode!,
        barcode = product.barcode,
        name = product.name,
        imageFrontUrl = product.imageFrontUrl,
        imageFrontSmallUrl = product.imageFrontSmallUrl,
        measure = null,
        expectedShelfLife = null,
        unsealedLifeTimeInDays = null;

  late String id;

  late String? barcode;

  late String? name;

  late String? imageFrontUrl;

  late String? imageFrontSmallUrl;

  late MeasureIsar? measure;

  late int? expectedShelfLife;

  late int? unsealedLifeTimeInDays;
}

@Embedded(ignore: {'copyWith'})
class MeasureIsar {
  MeasureIsar();

  MeasureIsar.fromEntity(Measure measure)
      : quantity = measure.quantity,
        unitOfMeasure = measure.unitOfMeasure;
  late double? quantity;

  @Enumerated(EnumType.name)
  late UnitOfMeasure? unitOfMeasure;

  MeasureIsar copyWith({
    double? quantity,
    UnitOfMeasure? unitOfMeasure,
  }) {
    return MeasureIsar()
      ..quantity = quantity ?? this.quantity
      ..unitOfMeasure = unitOfMeasure ?? this.unitOfMeasure;
  }
}
