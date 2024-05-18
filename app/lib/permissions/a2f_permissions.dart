import 'permissions.dart';

abstract class A2FPermissions {
  static A2FPermission camera = CameraPermission();

  static NotificationsPermission notifications = NotificationsPermission();
}
