import 'package:a2f_sdk/a2f_sdk.dart';

import '../../notifications_repository.dart';

abstract class NotificationsRepository
    extends CrudRepository<NotificationEntity, NotificationsRepositoryState> {
  /// Adds a notification.
  Future<void> add(NotificationInput input);

  /// Fetchs all notifications.
  Future<void> fetch();

  /// Read a notification by [id].
  Future<void> read(int id);
}
