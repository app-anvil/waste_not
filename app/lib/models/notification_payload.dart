import 'dart:async';

import 'package:a2f_sdk/a2f_sdk.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'notification_payload.g.dart';

/// {@template notification_payload}
/// Base class for notification payload. Eventually it can be extended.
///
/// It has a [route] memeber, which indicates the route name of the page that
/// will be opened on tap.
/// {@endtemplate}

@JsonSerializable(
  fieldRename: FieldRename.snake,
  createToJson: false,
  constructor: '_',
)
class NotificationPayload {
  /// {@macro notification_payload}
  NotificationPayload._({
    required this.route,
  });

  /// {@macro notification_payload}
  factory NotificationPayload.fromJson(Map<String, dynamic> json) =>
      _$NotificationPayloadFromJson(json);

  /// Indicates the name of the route.
  final String route;
}

extension NotificationPayloadHandler on NotificationPayload {
  Future<void> handle(BuildContext context) async {
    if (kDebugMode) {
      print('Handle notification payload: go to route: $route');
    }
    unawaited(context.router.pushNamed(route));
  }
}
