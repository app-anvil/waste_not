import 'dart:io';

import 'package:app_settings/app_settings.dart';
import 'package:flutter/widgets.dart';
import 'package:google_api_availability/google_api_availability.dart';
import 'package:permission_handler/permission_handler.dart';

import 'permissions.dart';

class NotificationsPermission extends A2FPermission {
  @override
  Permission get permission => Permission.notification;

  @override
  Future<PermissionStatus> get status => permission.status;

  /// Permission for scheduling exact alarms.
  ///
  /// Android 12+ (API 31+)
  // Permission get scheduleExactAlarm => Permission.scheduleExactAlarm;

  @override
  Future<bool> requestInternal({
    BuildContext? context,
    String? alertMessage,
  }) async {
    if (Platform.isAndroid) {
      final availability = await GoogleApiAvailability.instance
          .checkGooglePlayServicesAvailability(true);
      if (availability != GooglePlayServicesAvailability.success) {
        return false;
      }
    }

    // TODO: add default alert message
    return defaultRequestInternal(alertMessage: alertMessage ?? '');

    // This code is useless because the app does not request 
    //Permission.scheduleExactAlarm
    // var isGranted = false;
    // if (await permission.isDenied) {
    //   logger.i(
    //     'The user did not grant the permission for $permission}.'
    //     ' Asking them for it ...',
    //   );
    //   await permission.onDeniedCallback(() {
    //     logger.i('The user has denied the permission.');
    //     isGranted = false;
    //   }).onGrantedCallback(() {
    //     logger.i('The user has just granted the permission.');
    //     isGranted = true;
    //   }).onPermanentlyDeniedCallback(() {
    //     // Your code
    //   }).onRestrictedCallback(() {
    //     logger.i('The user has just restricted the permission.');
    //     isGranted = true;
    //   }).onLimitedCallback(() {
    //     logger.i('The user has just limited the permission.');
    //     isGranted = true;
    //   }).onProvisionalCallback(() {
    //     // Your code
    //   }).request();
    // }

    // if (isGranted) {
    //   if (!Platform.isAndroid) return isGranted;

    //   // ask schedule exact alarm permission
    //   var allowScheduleExactAlarm = false;
    //   logger.i(
    //     'The user did not grant the permission for $scheduleExactAlarm}.'
    //     ' Asking them for it ...',
    //   );
    //   await scheduleExactAlarm.onDeniedCallback(() {
    //     logger.i('The user has denied the permission.');
    //     allowScheduleExactAlarm = false;
    //   }).onGrantedCallback(() {
    //     logger.i('The user has just granted the permission.');
    //     allowScheduleExactAlarm = true;
    //   }).request();

    //   // use or because the user at least has granted the notifications
    //   // permission. I don't know what is the behavior.
    //   return isGranted || allowScheduleExactAlarm;
    // }

    // if (await permission.isPermanentlyDenied) {
    //   logger.i('The user has permanently denied the permission.');
    //   // eventually show dialog to open settings page
    //   await AppSettings.openAppSettings(
    //     type: AppSettingsType.notification,
    //   );
    //   return false;
    // }

    // if (await permission.isGranted) {
    //   logger.v('The user has already granted Waste Not the permission for '
    //       '$permission');
    //   return true;
    // }

    // logger.e(
    //   'Unexpected permission status: ${await permission.status}',
    // );
    // return false;
  }
}
