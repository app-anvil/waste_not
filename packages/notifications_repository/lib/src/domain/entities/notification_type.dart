/// {@template notification_type}
/// The enum of notification type.
///
/// expiringItem
///
/// expiredItem
///
/// openedItem
/// {@endtemplate}
enum NotificationType {
  expiringItem,
  expiredItem,
  openedItem;

  static NotificationType fromName(String? name) {
    return NotificationType.values.firstWhere(
      (element) => element.name == name,
    );
  }
}
