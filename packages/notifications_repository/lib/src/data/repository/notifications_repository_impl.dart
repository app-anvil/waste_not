import '../../../notifications_repository.dart';

class NotificationsRepositotyImpl extends NotificationsRepository {
  NotificationsRepositotyImpl(this._provider);

  final NotificationsProvider _provider;

  /// Internal map of notifications.
  ///
  /// Keys are the notifications' id.
  Map<int, NotificationEntity> _notificationsMap = {};

  @override
  Future<void> add(NotificationInput input) async {
    logger.v('Adding new notification ...');
    final notification = await _provider.add(input);
    _notificationsMap[notification.id.value] = notification;
    logger.v('$notification created added successfully in the repository');
    emit(NotificationsRepositoryNotificationAddedSuccess(notification));
  }

  NotificationEntity? getNotification(int id) => _notificationsMap[id];

  @override
  NotificationEntity getItemOrThrow(String id) =>
      getNotification(int.parse(id)) ??
      (throw StateError(
        '$NotificationModel $id not found in the repository',
      ));

  @override
  NotificationsRepositoryState get initialState =>
      NotificationsRepositoryInitial();

  @override
  List<NotificationEntity> get items => [..._notificationsMap.values];

  @override
  Future<void> read(int id) async {
    final notification = getItemOrThrow('$id');
    await _provider.read(notification.id.value);
    final readNotification = notification.copyWith(readAt: DateTime.now());
    _notificationsMap[notification.id.value] = readNotification;
    logger.v('$notification read');
    emit(NotificationsRepositoryNotificationReadSuccess(readNotification));
  }

  @override
  Future<void> fetch() async {
    logger.v('Fetching notifications ...');
    final tempMap = {..._notificationsMap};
    final notifications = await _provider.fetch();
    for (final notification in notifications) {
      tempMap[notification.id.value] = notification;
    }
    logger.d('${notifications.length} $NotificationEntity(s) fetched');
    emit(NotificationsRepositoryNotificationLoadedSuccess(notifications));
  }
}
