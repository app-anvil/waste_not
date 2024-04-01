import 'package:a2f_sdk/a2f_sdk.dart';
import 'package:storages_repository/storages_repository.dart';

import '../../../items_repository.dart';

class PantryItemModel extends ItemModel with ModelToStringMixin {
  const PantryItemModel({
    required super.uuid,
    required super.product,
    required super.expirationDate,
    required super.createdAt,
    required super.remainingMeasure,
    required super.storage,
    super.openedAt,
  });

  @override
  PantryItemModel copyWith({
    DateTime? expirationDate,
    Measure? remainingMeasure,
    StorageEntity? storage,
    Optional<DateTime?> openedAt = const Optional.absent(),
  }) {
    return PantryItemModel(
      uuid: uuid,
      product: product,
      expirationDate: expirationDate ?? this.expirationDate,
      createdAt: createdAt,
      remainingMeasure: remainingMeasure ?? this.remainingMeasure,
      storage: storage ?? this.storage,
      openedAt: openedAt.present ? openedAt.value : this.openedAt,
    );
  }

  @override
  Map<String, dynamic> $toMap() {
    return {
      'uuid': uuid,
      'remainingMeasure': remainingMeasure,
    };
  }
}
