import 'package:flutter_test/flutter_test.dart';
import 'package:notifications_repository/notifications_repository.dart';

import 'package:timezone/data/latest.dart' as tz_db;
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/timezone.dart';

typedef Json = Map<String, dynamic>;
void main() {
  setUp(() {
    TestWidgetsFlutterBinding.ensureInitialized();
    tz_db.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('Europe/Rome'));

    final now = DateTime.now();
    final nowUtc = now.toUtc();

    expect(
      tz.TZDateTime.from(now, tz.local),
      tz.TZDateTime.from(nowUtc, tz.local),
    );
  });
  test('NotificationModel creates instance of subclass of NotificationEntity',
      () {
    final notification = NotificationModel(
      type: NotificationType.expiredItem,
      createdAt: DateTime.now(),
      scheduledAt: TZDateTime.now(tz.local).add(const Duration(days: 4)),
    );
    expect(notification, isA<NotificationEntity>());
  });
}
