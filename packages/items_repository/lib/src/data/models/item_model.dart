import 'package:a2f_sdk/a2f_sdk.dart';
import 'package:products_repository/products_repository.dart';
import 'package:storages_repository/storages_repository.dart';

import '../../../items_repository.dart';

abstract class ItemModel with ModelToStringMixin implements ItemEntity {
  const ItemModel({
    required this.uuid,
    required this.product,
    required this.initialExpiryDate,
    required this.createdAt,
    required this.storage,
    required this.amount,
    this.unsealedLifeTimeInDays,
    this.openedAt,
  });

  @override
  final String uuid;

  @override
  final ProductEntity product;

  @override
  final DateTime initialExpiryDate;

  @override
  final DateTime createdAt;

  @override
  final DateTime? openedAt;

  @override
  final StorageEntity storage;

  @override
  final int? unsealedLifeTimeInDays;

  @override
  final int amount;

  ItemModel copyWith({
    DateTime? initialExpiryDate,
    StorageEntity? storage,
    Optional<DateTime?> openedAt,
    int? amount,
    int? unsealedLifeTimeInDays,
  });

  @override
  DateTime get actualExpiryDate {
    if (openedAt == null) {
      return initialExpiryDate.toDate();
    }
    // gets the minimum value from initialExpiryDate and openedAt + days.
    final minDate = [
      initialExpiryDate,
      openedAt!.add(Duration(days: unsealedLifeTimeInDays ?? 3)),
    ].reduce((a, b) => a.isBefore(b) ? a : b);
    return minDate.toDate();
  }

  @override
  List<Object?> get props => [
        uuid,
        product,
        storage,
        initialExpiryDate,
        openedAt,
        createdAt,
        amount,
        unsealedLifeTimeInDays,
      ];

  @override
  bool? get stringify => false;

  @override
  Map<String, dynamic> $toMap() {
    return {
      'uuid': uuid,
      'amount': amount,
      'product': product,
      'storage': storage,
      'initialExpiryDate': initialExpiryDate,
      'openedAt': openedAt,
      'createdAt': createdAt,
      'unsealedLifeTimeInDays': unsealedLifeTimeInDays,
    };
  }
}
