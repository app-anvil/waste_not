import 'package:items_repository/items_repository.dart';
import 'package:products_repository/products_repository.dart';

abstract class ItemModel implements ItemEntity {
  const ItemModel({
    required this.id,
    required this.product,
    required this.expirationDate,
    required this.createdAt,
    required this.remainingMeasure,
    required this.storage,
  });

  @override
  final String id;

  @override
  final ProductEntity product;

  @override
  final DateTime expirationDate;

  @override
  final DateTime createdAt;

  @override
  final Storage storage;

  @override
  final Measure remainingMeasure;

  ItemModel copyWith({
    DateTime? expirationDate,
    Measure? remainingMeasure,
    Storage? storage,
  });

  @override
  List<Object?> get props => [
        id,
        product,
        storage,
        expirationDate,
        remainingMeasure,
        createdAt,
      ];

  @override
  bool? get stringify => true;
}
