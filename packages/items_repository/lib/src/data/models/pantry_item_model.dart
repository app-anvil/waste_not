import 'package:a2f_sdk/a2f_sdk.dart';
import 'package:products_repository/products_repository.dart';
import 'package:storages_repository/storages_repository.dart';

import '../../../items_repository.dart';

class PantryItemModel extends ItemModel {
  const PantryItemModel({
    required super.uuid,
    required super.product,
    required super.initialExpiryDate,
    required super.createdAt,
    required super.storage,
    required super.amount,
    super.unsealedLifeTimeInDays,
    super.openedAt,
  });

  @override
  PantryItemModel copyWith({
    DateTime? initialExpiryDate,
    StorageEntity? storage,
    Optional<DateTime?> openedAt = const Optional.absent(),
    int? amount,
    int? unsealedLifeTimeInDays,
  }) {
    return PantryItemModel(
      uuid: uuid,
      product: product,
      initialExpiryDate: initialExpiryDate ?? this.initialExpiryDate,
      createdAt: createdAt,
      storage: storage ?? this.storage,
      openedAt: openedAt.present ? openedAt.value : this.openedAt,
      amount: amount ?? this.amount,
      unsealedLifeTimeInDays:
          unsealedLifeTimeInDays ?? this.unsealedLifeTimeInDays,
    );
  }
}
