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

  late DateTime expirationDate;

  late DateTime createdAt;

  late MeasureIsar remainingMeasure;

  late ProductIsar product;

  final storage = IsarLink<StorageDbModel>();

  ///
  late int? shelf;

  late DateTime? openedAt;

  ItemIsarModel copyWith({
    DateTime? expirationDate,
    MeasureIsar? remainingMeasure,
    StorageDbModel? storage,
    Optional<DateTime?> openedAt = const Optional.absent(),
    int? shelf,
  }) {
    return ItemIsarModel()
      ..id = id
      ..uuid = uuid
      ..createdAt = createdAt
      ..product = product
      ..shelf = shelf ?? this.shelf
      ..storage.value = storage ?? this.storage.value
      ..expirationDate = expirationDate ?? this.expirationDate
      ..remainingMeasure = remainingMeasure ?? this.remainingMeasure
      ..openedAt = openedAt.present ? openedAt.value : this.openedAt;
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
        expirationDate: expirationDate,
        createdAt: createdAt,
        remainingMeasure: Measure(
          quantity: remainingMeasure.quantity,
          unitOfMeasure: remainingMeasure.unitOfMeasure,
        ),
        openedAt: openedAt,
        storage: storage.value!,
        product: productModel,
      );
    }
    return ShelfItemModel(
      uuid: uuid,
      expirationDate: expirationDate,
      createdAt: createdAt,
      remainingMeasure: Measure(
        quantity: remainingMeasure.quantity,
        unitOfMeasure: remainingMeasure.unitOfMeasure,
      ),
      openedAt: openedAt,
      storage: storage.value!,
      product: productModel,
      // check value of null on isar
      shelf: shelf,
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
        imageFrontSmallUrl = product.imageFrontSmallUrl;

  late String id;

  late String? barcode;

  late String? name;

  late String? imageFrontUrl;

  late String? imageFrontSmallUrl;
}

@Embedded(ignore: {'copyWith'})
class MeasureIsar {
  MeasureIsar();

  MeasureIsar.fromEntity(Measure measure)
      : quantity = measure.quantity,
        unitOfMeasure = measure.unitOfMeasure;
  late double quantity;

  @Enumerated(EnumType.name)
  late UnitOfMeasure unitOfMeasure;

  MeasureIsar copyWith({
    double? quantity,
    UnitOfMeasure? unitOfMeasure,
  }) {
    return MeasureIsar()
      ..quantity = quantity ?? this.quantity
      ..unitOfMeasure = unitOfMeasure ?? this.unitOfMeasure;
  }
}
