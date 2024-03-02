import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

enum AppRoute {
  inventory,
  inventoryFilteredBy,
  scanner,
  addProduct,
  account,
  storages,
  addStorage,
  editStorage,

  editItem,
}

extension AppRoutePathExt on AppRoute {
  String get path => switch (this) {
        AppRoute.inventory => 'inventory',
        AppRoute.inventoryFilteredBy => 'filtered-by',
        AppRoute.scanner => 'scanner',
        AppRoute.addProduct => 'add-product',
        AppRoute.storages => 'storages',
        AppRoute.account => 'account',
        AppRoute.addStorage => 'add-storage',
        AppRoute.editStorage => 'edit-storage',
        AppRoute.editItem => 'edit-item',
      };

  String get rootPath => '/$path';

  /// Gets the location of the AppRoute.
  String location(BuildContext context) => context.namedLocation(name);
}
