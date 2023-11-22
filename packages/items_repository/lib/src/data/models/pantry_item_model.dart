import 'package:storages_repository/storages_repository.dart';

import '../../../items_repository.dart';

class PantryItemModel extends ItemModel {
  const PantryItemModel({
    required super.uuid,
    required super.product,
    required super.expirationDate,
    required super.createdAt,
    required super.remainingMeasure,
    required super.storage,
  });

  @override
  PantryItemModel copyWith({
    DateTime? expirationDate,
    Measure? remainingMeasure,
    StorageEntity? storage,
  }) {
    return PantryItemModel(
      uuid: uuid,
      product: product,
      expirationDate: expirationDate ?? this.expirationDate,
      createdAt: createdAt,
      remainingMeasure: remainingMeasure ?? this.remainingMeasure,
      storage: storage ?? this.storage,
    );
  }
}
