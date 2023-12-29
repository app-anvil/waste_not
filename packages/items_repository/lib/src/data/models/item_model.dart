import 'package:products_repository/products_repository.dart';
import 'package:storages_repository/storages_repository.dart';

import '../../../items_repository.dart';

abstract class ItemModel implements ItemEntity {
  const ItemModel({
    required this.uuid,
    required this.product,
    required this.expirationDate,
    required this.createdAt,
    required this.remainingMeasure,
    required this.storage,
    this.openedAt,
  });

  @override
  final String uuid;

  @override
  final ProductEntity product;

  @override
  final DateTime expirationDate;

  @override
  final DateTime createdAt;

  @override
  final DateTime? openedAt;

  @override
  final StorageEntity storage;

  @override
  final Measure remainingMeasure;

  ItemModel copyWith({
    DateTime? expirationDate,
    Measure? remainingMeasure,
    StorageEntity? storage,
  });

  @override
  List<Object?> get props => [
        uuid,
        product,
        storage,
        expirationDate,
        openedAt,
        remainingMeasure,
        createdAt,
      ];

  @override
  bool? get stringify => false;
}
