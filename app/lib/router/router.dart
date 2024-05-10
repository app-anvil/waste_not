// We start wth only one navigator key, because the bottom navigation bar
// should be present only in the root pages.
import 'dart:convert';

import 'package:a2f_sdk/a2f_sdk.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:products_repository/products_repository.dart';

import '../features/features.dart';
import '../widgets/scaffold_with_nested_navigation.dart';

export 'route_tokens.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _inventoryNavigatorKey = GlobalKey<NavigatorState>();
final _accountNavigatorKey = GlobalKey<NavigatorState>();

// Because child of routes doesn't have a bottom navigation bar, they use
// _rootNavigatorKey as a parentNavigationKey parameter.
final router = GoRouter(
  // FIXME: use / with redirect.
  initialLocation: '/inventory',
  navigatorKey: _rootNavigatorKey,
  debugLogDiagnostics: true,
  //extraCodec: const MyExtraCodec(),
  routes: [
    // /scanner
    ScannerPage.route,

    // /inventory/items/add
    AddItemPage.route,

    // /inventory/items/:itemId/edit
    EditItemPage.route,

    // /inventory/items/:itemId
    ItemPage.route,

    // /inventory/by-status?filter=...
    InventoryByStatusPage.route,

    // /inventory/storages
    StoragesPage.route,

    // /inventory/storages/add
    AddStoragePage.route,

    // /inventory/storages/:storageId/edit
    EditStoragePage.route,

    // initial routes with no app bar, e.g. login and sign up routes
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return ScaffoldWithNestedNavigation(
          navigationShell: navigationShell,
        );
      },
      branches: [
        StatefulShellBranch(
          navigatorKey: _inventoryNavigatorKey,
          routes: [InventoryPage.route],
        ),
        StatefulShellBranch(
          navigatorKey: _accountNavigatorKey,
          routes: [AccountPage.route],
        ),
      ],
    ),
  ],
  redirect: (context, state) {
    const NthLogger('Router').v('Redirect: ${state.uri}');
    return null;
  },
);

/// A codec that can serialize [ProductEntity].
class MyExtraCodec extends Codec<Object?, Object?> {
  /// Create a codec.
  const MyExtraCodec();
  @override
  Converter<Object?, Object?> get decoder => const _MyExtraDecoder();

  @override
  Converter<Object?, Object?> get encoder => const _MyExtraEncoder();
}

class _MyExtraDecoder extends Converter<Object?, Object?> {
  const _MyExtraDecoder();
  @override
  Object? convert(Object? input) {
    if (input == null) {
      return null;
    }
    final inputAsList = input as List<Object?>;
    if (inputAsList.first == 'ProductEntity') {
      return inputAsList.last! as ProductEntity;
    }
    throw FormatException('Unable tp parse input: $input');
  }
}

class _MyExtraEncoder extends Converter<Object?, Object?> {
  const _MyExtraEncoder();
  @override
  Object? convert(Object? input) {
    if (input == null) {
      return null;
    }
    if (input is ProductEntity) {
      return <Object?>['ProductEntity', input];
    }
    throw FormatException('Cannot encode type ${input.runtimeType}');
  }
}
