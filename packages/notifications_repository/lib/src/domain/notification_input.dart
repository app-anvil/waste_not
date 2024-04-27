import 'package:timezone/timezone.dart' as tz;

import 'domain.dart';

/// Use this class to create a new notification.
class NotificationInput {
  const NotificationInput({
    required this.type,
    required this.scheduledAt,
    required this.location,
    this.uuid,
    this.readAt,
    this.intVal,
    this.stringVal,
    this.boolVal,
    this.dateTimeVal,
  });

  final NotificationType type;

  /// The remote identifier. Useful for push notifications.
  final String? uuid;

  /// Indicates the date time when the notification is read.
  final DateTime? readAt;

  /// Indicates the date time when the notification must be shown in the page.
  final tz.TZDateTime scheduledAt;

  final int? intVal;

  /// The string value of the notification. e.g. can be the uuid of the referred
  /// item.
  final String? stringVal;

  final bool? boolVal;

  final DateTime? dateTimeVal;

  final tz.Location location;
}
