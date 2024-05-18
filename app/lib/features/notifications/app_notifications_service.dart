import 'dart:async';

import 'package:a2f_sdk/a2f_sdk.dart';
import 'package:items_repository/items_repository.dart';

/// This service is in charge of scheduling the app (system) notification.
///
/// Also it is charge of re-scheduling or deleting a notification based on
/// the activity of the user.
class AppNotificationService {
  final NotificationService _localNotificationService;
  final ItemsRepository _itemsRepository;

  late final StreamSubscription<ObservableEvent<ItemsRepositoryState>>
      _itemsSubscription;

  AppNotificationService(
    this._itemsRepository,
    this._localNotificationService,
  ) {
    _itemsSubscription = _itemsRepository.listen((_, currentState) {
      // listen add items, edit (open item), full consume
      if (currentState is ItemsRepositoryItemAddedSuccess) {
        _onAddItem(currentState.item);
      }
      if (currentState is ItemsRepositoryItemOpenedSuccess) {
        _onOpenItem(currentState.item);
      }
      if (currentState is ItemsRepositoryItemUnOpenedSuccess) {
        _onUnOpenItem(currentState.item);
      }
      if (currentState is ItemsRepositoryItemFullConsumedSuccess) {
        _onFullConsumeItem(currentState.item);
      }
    });
  }

  /// Returns true if the notification should be scheduled.
  ///
  /// Checks on local db if exist a notification with [type] scheduled at
  /// [scheduledAt].
  // TODO: use NotificationType insteaead of String.
  Future<bool> _shouldBeScheduled({
    required DateTime scheduledAt,
    required String type,
  }) async {
    return true;
  }

  Future<void> _addExpiringItemNotification(ItemEntity item) async {
    final expiredAt = item.initialExpiryDate.toDate();

    // TODO:
    // check on db if exists already at least a notification with this type for
    // the same day. if not creates a notification entity and schedules an
    // app notification.
    final toBeScheduled = await _shouldBeScheduled(
      scheduledAt: expiredAt,
      type: 'expiring',
    );
    if (toBeScheduled) {
      // TODO: create the notification on local db.

      final expiredNotification = ReceivedNotification.fromLocal(
        title: '',
        payload: {
          'route': 'notifications',
        },
      );

      // FIXME: use user's preferences
      final scheduledAt = expiredAt
          .subtract(const Duration(days: 2))
          .copyWith(hour: 19, minute: 00);

      await _localNotificationService.scheduleNotification(
        expiredNotification,
        scheduleAt: scheduledAt,
      );
    }
  }

  Future<void> _addExpiredItemNotification(ItemEntity item) async {
    final expiredAt = item.initialExpiryDate.toDate();

    final toBeScheduled = await _shouldBeScheduled(
      scheduledAt: expiredAt,
      type: 'expired',
    );

    if (toBeScheduled) {
      // TODO: create the notification on local db.

      final expiredNotification = ReceivedNotification.fromLocal(
        title: '',
        payload: {
          'route': 'notifications',
        },
      );

      // FIXME: use user's preferences
      final scheduledAt = expiredAt.copyWith(hour: 19, minute: 00);

      await _localNotificationService.scheduleNotification(
        expiredNotification,
        scheduleAt: scheduledAt,
      );
    }
  }

  /// Add all required notifications when a new item is added.
  Future<void> _onAddItem(ItemEntity item) async {
    // schedule a notification 2 day before items will be expired.
    await _addExpiringItemNotification(item);

    // schedule a notification when item is expired.
    await _addExpiredItemNotification(item);
  }

  /// Schedule a notification when an item is opened.
  Future<void> _onOpenItem(ItemEntity item) async {}

  /// Cancel a notification of type 'itemOpened' when an item is unopened and
  /// deletes the notification entity from the db. The id is the same.
  Future<void> _onUnOpenItem(ItemEntity item) async {
    // TODO: get the notification id from the local db.
    const id = -1;
    // TODO: delete the notification entity from the db.

    unawaited(_localNotificationService.cancelNotification(id));
  }

  /// Cancel all notifications referred to the item and deltes notifications
  /// from the db.
  Future<void> _onFullConsumeItem(ItemEntity item) async {}

  // schedule a daily notification

  void pause() {
    _itemsSubscription.pause();
  }

  void resume() {
    _itemsSubscription.resume();
  }
}
