import 'package:a2f_sdk/a2f_sdk.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:get_it/get_it.dart';
import 'package:items_repository/items_repository.dart';
import 'package:products_repository/products_repository.dart';
import 'package:storages_repository/storages_repository.dart';
import 'package:timezone/data/latest_all.dart' as tz_db;
import 'package:timezone/timezone.dart' as tz;

import '../db/isar_service.dart';

const $notificationMessageHandlerInstanceName = 'NotificationMessageHandler';

Future<void> initializeDependencies() async {
  /// Provides the local notification plugin
  GetIt.I.registerSingleton<FlutterLocalNotificationsPlugin>(
    FlutterLocalNotificationsPlugin(),
  );

  tz_db.initializeTimeZones();
  final timeZoneName = await FlutterTimezone.getLocalTimezone();
  tz.setLocalLocation(tz.getLocation(timeZoneName));

  // TODO: use NOtificationPayload as a type.
  final notificationPayloadHandler =
      GetIt.I.registerSingleton<StreamControllerHandler<Map<String, dynamic>>>(
    StreamControllerHandler(),
    // use instance name to get its instance
    instanceName: $notificationMessageHandlerInstanceName,
  );

  GetIt.I.registerSingleton<MessageHelper>(MessageHelper());
  GetIt.I.registerSingleton<IsarService>(IsarServiceImpl());
  GetIt.I.registerSingleton<ProductsApiClient>(OpenFoodFactsApiClient());
  GetIt.I.registerSingleton<StoragesRepository>(
    StoragesRepositoryImpl(StoragesDbProvider(GetIt.I.get<IsarService>())),
  );

  GetIt.I.registerSingleton<ItemsRepository>(
    ItemsRepositoryImpl(ItemsDbProvider(GetIt.I.get<IsarService>())),
  );

  final notificationsService = GetIt.I.registerSingleton<NotificationService>(
    NotificationService(
      GetIt.I.get<FlutterLocalNotificationsPlugin>(),
      notificationPayloadHandler,
    ),
  );

  await notificationsService.initializationDone;
}
