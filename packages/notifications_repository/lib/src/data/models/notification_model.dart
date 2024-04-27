import 'package:a2f_sdk/a2f_sdk.dart';
import 'package:timezone/timezone.dart' as tz;

import '../../notifications_repository.dart';

class NotificationModel extends NotificationEntity {
  const NotificationModel({
    required super.type,
    required super.createdAt,
    required super.scheduledAt,
    super.uuid,
    super.readAt,
    super.id,
    super.intVal,
    super.stringVal,
    super.boolVal,
    super.dateTimeVal,
  });

  factory NotificationModel.fromData(NotificationIsarModel data) {
    final scheduledAt = tz.TZDateTime.from(
      data.scheduledAt,
      tz.local,
    );
    return NotificationModel(
      id: Optional(data.id),
      uuid: data.uuid,
      type: data.type,
      createdAt: data.createdAt.toUtc(),
      scheduledAt: scheduledAt,
      readAt: data.readAt,
      intVal: data.intVal,
      stringVal: data.stringVal,
      boolVal: data.boolVal,
      dateTimeVal: data.dateTimeVal,
    );
  }

  @override
  NotificationModel copyWith({Optional<int>? id, DateTime? readAt}) {
    return NotificationModel(
      id: id ?? this.id,
      scheduledAt: scheduledAt,
      type: type,
      createdAt: createdAt,
      intVal: intVal,
      stringVal: stringVal,
      boolVal: boolVal,
      dateTimeVal: dateTimeVal,
      readAt: readAt ?? this.readAt,
      uuid: uuid,
    );
  }
}
