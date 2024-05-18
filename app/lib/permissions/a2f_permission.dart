import 'package:a2f_sdk/a2f_sdk.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:permission_handler/permission_handler.dart';

abstract class A2FPermission with LoggerMixin {
  @protected
  Permission get permission;

  Future<PermissionStatus> get status;

  Future<bool> get isGranted async => permission.isGranted;

  @protected
  @nonVirtual
  Future<bool> defaultRequestInternal({
    required String alertMessage,
    BuildContext? context,
    void Function()? openSettingsPage,
    Future<void> Function()? showPermissionDialog,
  }) async {
    if (await permission.isDenied) {
      logger.i('The user did not grant the permission for '
          '$permission. Asking them for it...');
      final status = await permission.request();
      if (status.isGranted) {
        logger.i('The user has just granted the permission for '
            '$permission');
        return true;
      }
      if (status.isLimited) {
        logger.i('The user has just limited granted the permission for '
            '$permission');
        return true;
      } else {
        logger.i('The user has denied the permission for '
            '$permission');
        if (context != null) {
          await showPermissionDialog?.call();
          // await WPermissionDialog.show(
          //   context: context,
          //   text: alertMessage,
          // );
        }
        return false;
      }
    }

    if (await permission.isPermanentlyDenied) {
      logger.w('The user has PERMANENTLY denied the permission for '
          '$permission');
      if (context != null) {
        await showPermissionDialog?.call();
        // await WPermissionDialog.show(
        //   context: context,
        //   text: alertMessage,
        //   onConfirm: openSettingsPage,
        // );
      }
      return false;
    }

    if (await permission.isGranted) {
      logger.v('The user has already granted Wayt the permission for '
          '$permission');
      return true;
    }

    logger.e('Unexpected permission status '
        '=${await permission.status}');
    return false;
  }

  @protected
  Future<bool> requestInternal({
    BuildContext? context,
    String? alertMessage,
  });

  @nonVirtual
  Future<bool> request() => requestInternal();

  @nonVirtual
  Future<bool> requestWithAlert({
    required BuildContext context,
    String? alertMessage,
  }) =>
      requestInternal(
        context: context,
        alertMessage: alertMessage,
      );
}
