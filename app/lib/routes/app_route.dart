import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

enum AppRoute {
  pantry,
  scanner,
  addProduct,
  account,
}

extension AppRoutePathExt on AppRoute {
  String get path => switch (this) {
        AppRoute.pantry => 'pantry',
        AppRoute.scanner => 'scanner',
        AppRoute.addProduct => 'add-product',
        AppRoute.account => 'account',
      };

  String get rootPath => '/$path';

  /// Gets the location of the AppRoute.
  String location(BuildContext context) => context.namedLocation(name);
}
