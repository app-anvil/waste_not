import 'package:a2f_sdk/a2f_sdk.dart';

import '../../../notifications_repository.dart';

sealed class NotificationsRepositoryState extends Equatable {
  const NotificationsRepositoryState();

  @override
  bool? get stringify => false;
}

class NotificationsRepositoryInitial extends NotificationsRepositoryState {
  @override
  List<Object?> get props => [];
}

class NotificationsRepositoryNotificationAddedSuccess
    extends NotificationsRepositoryState {
  final NotificationEntity notification;

  const NotificationsRepositoryNotificationAddedSuccess(this.notification);

  @override
  List<Object?> get props => [notification];
}

class NotificationsRepositoryNotificationReadSuccess
    extends NotificationsRepositoryState {
  final NotificationEntity notification;

  const NotificationsRepositoryNotificationReadSuccess(this.notification);

  @override
  List<Object?> get props => [notification];
}

class NotificationsRepositoryNotificationLoadedSuccess
    extends NotificationsRepositoryState {
  final List<NotificationEntity> notifications;

  const NotificationsRepositoryNotificationLoadedSuccess(this.notifications);

  @override
  List<Object?> get props => [notifications];
}
