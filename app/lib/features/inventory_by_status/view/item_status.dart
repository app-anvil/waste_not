import 'package:a2f_sdk/a2f_sdk.dart';
import 'package:items_repository/items_repository.dart';

/// Indicates the status of an item.
///
/// Can be one of the following values:
///
/// - expired
///
/// - opned
///
/// - toBeEaten
enum ItemStatus {
  normal,
  expired,
  opened,
  toBeEaten;

  bool get isNormal => this == normal;
  bool get isExpired => this == expired;
  bool get isOpened => this == opened;
  bool get isToBeEaten => this == toBeEaten;

  factory ItemStatus.fromName(String name) =>
      ItemStatus.values.firstWhere((e) => e.name == name);

  static ItemStatus fromItem(ItemEntity item) {
    if (item.initialExpiryDate.toDate().isBefore(DateTime.now().toDate())) {
      return ItemStatus.expired;
    } else if (item.openedAt != null) {
      return ItemStatus.opened;
    }
    final remainingDays = item.initialExpiryDate
        .toDate()
        .difference(DateTime.now().toDate())
        .inDays;
    if (remainingDays >= 0 &&
        remainingDays <= ItemEntity.shouldBeEatenBeforeDays) {
      return ItemStatus.toBeEaten;
    }
    return ItemStatus.normal;
  }
}
