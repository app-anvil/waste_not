import '../../../notifications_repository.dart';

/// This provider return [NotificationEntity] object because does not exist a
/// concrete implementation of model that extends [NotificationEntity].
abstract class NotificationsProvider {
  Future<NotificationModel> add(NotificationInput input);

  Future<List<NotificationModel>> fetch();

  Future<NotificationModel> read(int id);

  Future<bool> exists({
    int? id,
    NotificationType? type,
    DateTime? scheduledAt,
  });
}
