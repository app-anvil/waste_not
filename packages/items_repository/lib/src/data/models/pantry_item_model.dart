import 'package:items_repository/items_repository.dart';

class PantryItemModel extends ItemModel {
   const PantryItemModel({
    required super.id,
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
    Storage? storage,
  }) {
    return PantryItemModel(
      id: id,
      product: product,
      expirationDate: expirationDate ?? this.expirationDate,
      createdAt: createdAt,
      remainingMeasure: remainingMeasure ?? this.remainingMeasure,
      storage: storage ?? this.storage,
    );
  }
}