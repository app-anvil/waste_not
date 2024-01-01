import 'package:aev_sdk/aev_sdk.dart';
import 'package:storages_repository/storages_repository.dart';

import '../../../items_repository.dart';

class ShelfItemModel extends ItemModel implements ShelfItemEntity {
  ShelfItemModel({
    required super.uuid,
    required super.product,
    required super.expirationDate,
    required super.createdAt,
    required super.remainingMeasure,
    required super.storage,
    super.openedAt,
    this.shelf,
  }) : assert(
          storage.storageType == StorageType.fridge ||
              storage.storageType == StorageType.freezer,
          'The type of the storage must be fridge or freezer',
        );

  @override
  ShelfItemModel copyWith({
    DateTime? expirationDate,
    Measure? remainingMeasure,
    StorageEntity? storage,
    Optional<DateTime?> openedAt = const Optional.absent(),
    int? shelf,
  }) {
    return ShelfItemModel(
      uuid: uuid,
      product: product,
      createdAt: createdAt,
      expirationDate: expirationDate ?? this.expirationDate,
      remainingMeasure: remainingMeasure ?? this.remainingMeasure,
      storage: storage ?? this.storage,
      openedAt: openedAt.present ? openedAt.value : this.openedAt,
      shelf: shelf ?? this.shelf,
    );
  }

  @override
  final int? shelf;

  @override
  List<Object?> get props => [...super.props, shelf];
}
