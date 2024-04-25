import 'package:a2f_sdk/a2f_sdk.dart';
import 'package:storages_repository/storages_repository.dart';

import '../../../items_repository.dart';

class ShelfItemModel extends ItemModel implements ShelfItemEntity {
  ShelfItemModel({
    required super.uuid,
    required super.product,
    required super.initialExpiryDate,
    required super.createdAt,
    required super.storage,
    required super.amount,
    super.openedAt,
    super.unsealedLifeTimeInDays,
    this.shelf,
  }) : assert(
          storage.storageType == StorageType.fridge ||
              storage.storageType == StorageType.freezer,
          'The type of the storage must be fridge or freezer',
        );

  @override
  ShelfItemModel copyWith({
    DateTime? initialExpiryDate,
    StorageEntity? storage,
    Optional<DateTime?> openedAt = const Optional.absent(),
    int? amount,
    int? shelf,
    int? unsealedLifeTimeInDays,
  }) {
    return ShelfItemModel(
      uuid: uuid,
      product: product,
      createdAt: createdAt,
      initialExpiryDate: initialExpiryDate ?? this.initialExpiryDate,
      storage: storage ?? this.storage,
      openedAt: openedAt.present ? openedAt.value : this.openedAt,
      shelf: shelf ?? this.shelf,
      amount: amount ?? this.amount,
      unsealedLifeTimeInDays:
          unsealedLifeTimeInDays ?? this.unsealedLifeTimeInDays,
    );
  }

  @override
  final int? shelf;

  @override
  List<Object?> get props => [...super.props, shelf];

  @override
  bool shouldBeMergedWith(ItemModel other) {
    return super.shouldBeMergedWith(other) &&
        ((other is ShelfItemEntity &&
                (other as ShelfItemEntity).shelf == shelf) ||
            other is! ShelfItemEntity);
  }
}
