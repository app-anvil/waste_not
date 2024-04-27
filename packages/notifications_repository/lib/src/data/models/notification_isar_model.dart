import 'package:a2f_sdk/a2f_sdk.dart';

import '../../domain/domain.dart';

part 'notification_isar_model.g.dart';

@Collection(ignore: {'copyWith'})
class NotificationIsarModel {
  Id id = Isar.autoIncrement;

  @Enumerated(EnumType.name)
  late NotificationType type;

  /// The remote identifier. Useful for push notifications.
  late String? uuid;

  /// Indicates the date time when the notification is read.
  ///
  /// The date time is in UTC
  late DateTime? readAt;

  /// Indicates the date time when the notification is created.
  ///
  /// The date time is in UTC
  late DateTime createdAt;

  /// Indicates the date time when the notification must be shown in the page.
  ///
  /// The date time is in UTC
  late DateTime scheduledAt;

  late int? intVal;

  /// The string value of the notification. e.g. can be the uuid of the referred
  /// item.
  late String? stringVal;

  late bool? boolVal;

  late DateTime? dateTimeVal;

  /// The geographical area when a notification is created.
  ///
  /// E.g. CEST
  late String location;

  NotificationIsarModel copyWith({
    DateTime? readAt,
  }) {
    return NotificationIsarModel()
      ..id = id
      ..uuid = uuid
      ..type = type
      ..readAt = readAt ?? this.readAt
      ..createdAt = createdAt
      ..scheduledAt = scheduledAt
      ..intVal = intVal
      ..stringVal = stringVal
      ..boolVal = boolVal
      ..dateTimeVal = dateTimeVal
      ..location = location;
  }
}
