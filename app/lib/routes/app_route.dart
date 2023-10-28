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
}
