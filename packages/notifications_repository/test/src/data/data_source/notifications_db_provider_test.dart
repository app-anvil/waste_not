import 'package:a2f_sdk/a2f_sdk.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:notifications_repository/notifications_repository.dart';
import 'package:timezone/data/latest.dart' as tz_db;
import 'package:timezone/timezone.dart' as tz;

class MockIsarService extends Mock implements IsarService {}

void main() {
  late Isar isar;

  late NotificationsDbProvider provider;

  setUpAll(() async {
    tz_db.initializeTimeZones();

    await Isar.initializeIsarCore(download: true);
    final mockIsarService = MockIsarService();
    isar = await Isar.open(
      [NotificationIsarModelSchema],
      directory: '',
    );
    when<Future<Isar>>(() => mockIsarService.db).thenAnswer(
      (_) async => isar,
    );
    provider = NotificationsDbProvider(mockIsarService);
  });

  tearDownAll(() {
    isar.close(deleteFromDisk: true);
  });

  setUp(() async {
    await isar.writeTxn(() async {
      await isar.notificationIsarModels.clear();
    });
  });

  test('Add a new notification', () async {
    final location = tz.getLocation('Europe/Rome');
    final now = DateTime.now();

    final input = NotificationInput(
      type: NotificationType.expiredItem,
      scheduledAt: tz.TZDateTime.from(now, location),
      location: location,
    );

    final notification = await provider.add(input);
   
    expect(now.isUtc, false);
    expect(notification.scheduledAt.isLocal, true);
    expect(notification.scheduledAt.isAtSameMomentAs(now), true);

    final results = await provider.fetch();

    expect(results.isEmpty, false);
    expect(results.length, 1);
    expect(results.first.scheduledAt.isAtSameMomentAs(now), true);
  });

  test('Read a new notification', () async {
    final location = tz.getLocation('Europe/Rome');
    final now = DateTime.now();

    final input = NotificationInput(
      type: NotificationType.expiredItem,
      scheduledAt: tz.TZDateTime.from(now, location),
      location: location,
    );

    final notification = await provider.add(input);

    final resultsBefore = await provider.fetch();

    expect(resultsBefore.first.readAt, null);
    expect(resultsBefore.first.isRead, false);

    await provider.read(notification.id.value);

    final resultsAfter = await provider.fetch();

    expect(resultsAfter.isEmpty, false);
    expect(resultsAfter.length, 1);
    expect(resultsAfter.first.readAt, isNot(null));
    expect(resultsAfter.first.isRead, true);
  });

  group('Exists', () {
    test('Exists a notification by id', () async {
      final location = tz.getLocation('Europe/Rome');
      final now = DateTime.now();

      final input = NotificationInput(
        type: NotificationType.expiredItem,
        scheduledAt: tz.TZDateTime.from(now, location),
        location: location,
      );

      final notification = await provider.add(input);

      final result = await provider.exists(
        id: notification.id.value,
      );

      final result2 = await provider.exists(
        id: 2,
      );

      expect(result, true);
      expect(result2, false);
    });
    test('Exists a notification with type and date', () async {
      final location = tz.getLocation('Europe/Rome');
      final now = DateTime.now();

      final input = NotificationInput(
        type: NotificationType.expiredItem,
        scheduledAt: tz.TZDateTime.from(now, location),
        location: location,
      );

      await provider.add(input);

      final result = await provider.exists(
        type: NotificationType.expiredItem,
        scheduledAt: DateTime.now(),
      );

      expect(result, true);
    });

    test('Exists no a notification with type and date', () async {
      final location = tz.getLocation('Europe/Rome');
      final now = DateTime.now();

      final input = NotificationInput(
        type: NotificationType.expiredItem,
        scheduledAt: tz.TZDateTime.from(now, location),
        location: location,
      );

      await provider.add(input);

      final result = await provider.exists(
        type: NotificationType.expiringItem,
        scheduledAt: DateTime.now(),
      );

      final result2 = await provider.exists(
        type: NotificationType.expiredItem,
        scheduledAt: DateTime.now().add(const Duration(days: 1)),
      );

      expect(result, false);

      expect(result2, false);
    });

    test('Exists throw AssertionError', () async {
      final location = tz.getLocation('Europe/Rome');
      final now = DateTime.now();

      final input = NotificationInput(
        type: NotificationType.expiredItem,
        scheduledAt: tz.TZDateTime.from(now, location),
        location: location,
      );

      await provider.add(input);

      expect(() async => provider.exists(), throwsA(isA<AssertionError>()));
    });
  });
}
