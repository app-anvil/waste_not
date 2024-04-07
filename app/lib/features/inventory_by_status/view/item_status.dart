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

  static ItemStatus fromValue(String value) {
    if (value == 'expired') {
      return ItemStatus.expired;
    } else if (value == 'opened') {
      return ItemStatus.opened;
    } else if (value == 'normal') {
      return ItemStatus.normal;
    } else {
      return ItemStatus.toBeEaten;
    }
  }

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
