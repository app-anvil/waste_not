import 'package:a2f_sdk/a2f_sdk.dart';
import 'package:timezone/timezone.dart';

import '../../notifications_repository.dart';

abstract class NotificationEntity extends Equatable {
  const NotificationEntity({
    required this.type,
    required this.createdAt,
    required this.scheduledAt,
    this.id = const Optional.absent(),
    this.uuid,
    this.readAt,
    this.intVal,
    this.stringVal,
    this.boolVal,
    this.dateTimeVal,
  });

  final NotificationType type;

  /// The local id of a notification.
  final Optional<int> id;

  /// The remote identifier. Useful for push notifications.
  final String? uuid;

  /// Indicates the date time when the notification is read.
  ///
  /// This date time is in UTC.
  final DateTime? readAt;

  /// Indicates the date time when the notification is created.
  ///
  /// This date time is in UTC.
  final DateTime createdAt;

  /// Indicates the date time when the notification must be shown in the page.
  final TZDateTime scheduledAt;

  final int? intVal;

  /// The string value of the notification. e.g. can be the uuid of the referred
  /// item.
  final String? stringVal;

  final bool? boolVal;

  final DateTime? dateTimeVal;

  bool get isRead => readAt != null;

  // TODO: check timezone
  bool get toBeShown => scheduledAt.isAfter(DateTime.now()) && !isRead;

  @override
  List<Object?> get props => [
        id,
        uuid,
        readAt,
        createdAt,
        scheduledAt,
        intVal,
        stringVal,
        boolVal,
        dateTimeVal,
        type,
      ];

  NotificationEntity copyWith({
    Optional<int>? id,
    DateTime? readAt,
  });
}
