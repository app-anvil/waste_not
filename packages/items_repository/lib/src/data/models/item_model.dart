import 'package:a2f_sdk/a2f_sdk.dart';
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
  ItemStatus get status {
    if (expirationDate.toDate().isBefore(DateTime.now().toDate())) {
      return ItemStatus.expired;
    } else if (openedAt != null) {
      return ItemStatus.opened;
    }
    final remainingDays =
        expirationDate.toDate().difference(DateTime.now().toDate()).inDays;
    if (remainingDays >= 0 &&
        remainingDays <= ItemEntity.shouldBeItemBeforeDays) {
      return ItemStatus.toBeEaten;
    }
    return ItemStatus.normal;
  }

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
