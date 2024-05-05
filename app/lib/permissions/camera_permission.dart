import 'package:flutter/widgets.dart';
import 'package:permission_handler/permission_handler.dart';

import 'permissions.dart';

class CameraPermission extends A2FPermission {
  @override
  Permission get permission => Permission.camera;

  @override
  Future<PermissionStatus> get status => permission.status;

  @override
  Future<bool> requestInternal({
    BuildContext? context,
    String? alertMessage,
  }) async {
    return defaultRequestInternal(alertMessage: alertMessage ?? '');
  }
}
