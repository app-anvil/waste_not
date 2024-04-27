import 'package:a2f_sdk/a2f_sdk.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:notifications_repository/notifications_repository.dart';

import 'package:timezone/data/latest.dart' as tz_db;
import 'package:timezone/timezone.dart' as tz;

class MockNotificationsProvider extends Mock implements NotificationsProvider {}

typedef Json = Map<String, dynamic>;

void main() {
  late MockNotificationsProvider mockNotificationsProvider;

  late NotificationsRepositotyImpl notificationsRepositotyImpl;

  late NotificationModel notification;

  setUp(() {
    TestWidgetsFlutterBinding.ensureInitialized();
    tz_db.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('Europe/Rome'));

    mockNotificationsProvider = MockNotificationsProvider();
    notificationsRepositotyImpl =
        NotificationsRepositotyImpl(mockNotificationsProvider);

    notification = NotificationModel(
      id: const Optional(1),
      type: NotificationType.expiredItem,
      createdAt: DateTime.now(),
      scheduledAt: tz.TZDateTime.now(tz.local).add(const Duration(days: 4)),
    );
  });

  test('Add new notification', () async {
    final input = NotificationInput(
      type: NotificationType.expiredItem,
      scheduledAt: tz.TZDateTime.now(tz.local).add(const Duration(days: 4)),
      location: tz.local,
    );
    // arrange
    when<Future<NotificationModel>>(() => mockNotificationsProvider.add(input))
        .thenAnswer(
      (invocation) async => notification,
    );

    // execute
    await notificationsRepositotyImpl.add(input);

    // verify
    expect(notificationsRepositotyImpl.items.length, 1);
    expect(notificationsRepositotyImpl.items.first.isRead, false);
  });

  test('Read a notification', () async {
    final input = NotificationInput(
      type: NotificationType.expiredItem,
      scheduledAt: tz.TZDateTime.now(tz.local).add(const Duration(days: 4)),
      location: tz.local,
    );

    // arrange
    when<Future<NotificationModel>>(() => mockNotificationsProvider.add(input))
        .thenAnswer(
      (invocation) async => notification,
    );
    when<Future<NotificationModel>>(
      () => mockNotificationsProvider.read(notification.id.value),
    ).thenAnswer(
      (invocation) async => notification.copyWith(readAt: DateTime.now()),
    );

    // execute
    await notificationsRepositotyImpl.add(input);

    await notificationsRepositotyImpl.read(notification.id.value);

    // verify
    expect(notificationsRepositotyImpl.items.length, 1);
    expect(notificationsRepositotyImpl.items.first.isRead, true);
  });
}
