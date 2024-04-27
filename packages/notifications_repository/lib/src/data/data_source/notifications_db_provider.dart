import 'package:a2f_sdk/a2f_sdk.dart';

import '../../../notifications_repository.dart';

class NotificationsDbProvider implements NotificationsProvider {
  const NotificationsDbProvider(this._dbService);

  final IsarService _dbService;

  @override
  Future<NotificationModel> add(NotificationInput input) async {
    final isar = await _dbService.db;
    final createdAt = DateTime.now();

    final notification = NotificationIsarModel()
      ..type = input.type
      ..createdAt = createdAt
      ..scheduledAt = input.scheduledAt
      ..intVal = input.intVal
      ..stringVal = input.stringVal
      ..boolVal = input.boolVal
      ..dateTimeVal = input.dateTimeVal
      ..location = input.location.name
      ..uuid = null
      ..readAt = null;

    final id = await isar.writeTxn(
      () async => isar.notificationIsarModels.put(notification),
    );

    final data =
        await isar.notificationIsarModels.where().idEqualTo(id).findFirst();

    return NotificationModel.fromData(data!);
  }

  @override
  Future<List<NotificationModel>> fetch() async {
    final isar = await _dbService.db;
    final items = await isar.notificationIsarModels
        .where()
        .sortByScheduledAtDesc()
        .findAll();
    return items.map(NotificationModel.fromData).toList();
  }

  @override
  Future<NotificationModel> read(int id) async {
    final isar = await _dbService.db;

    return isar.writeTxn(() async {
      final notification =
          await isar.notificationIsarModels.where().idEqualTo(id).findFirst();

      if (notification == null) {
        throw AssertionError('Notification must exist');
      }

      final updated = notification.copyWith(readAt: DateTime.now());
      await isar.notificationIsarModels.put(updated);

      return NotificationModel.fromData(updated);
    });
  }

  @override
  Future<bool> exists({
    int? id,
    NotificationType? type,
    DateTime? scheduledAt,
  }) async {
    if (id == null && type == null && scheduledAt == null) {
      throw AssertionError('At least one parameter must be provided.');
    }
    final isar = await _dbService.db;
    if (id != null) {
      final count =
          await isar.notificationIsarModels.where().idEqualTo(id!).count();
      return count > 0;
    }
    assert(type != null && scheduledAt != null, '');
    final date = scheduledAt!;
    final dateStart = DateTime.utc(date.year, date.month, date.day, 0, 0, 0);
    final dateEnd = DateTime.utc(date.year, date.month, date.day, 23, 59, 59);
    final count = await isar.notificationIsarModels
        .filter()
        .typeEqualTo(type!)
        .and()
        .scheduledAtBetween(dateStart, dateEnd)
        .count();
    return count > 0;
  }
}
