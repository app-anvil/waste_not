import '../../../items_repository.dart';

/// An [ItemEntity] with an optional [shelf].
abstract interface class ShelfItemEntity implements ItemEntity {
  /// The shelf of the storage where the user puts the item.
  ///
  /// It is optional.
  abstract final int? shelf;
}
