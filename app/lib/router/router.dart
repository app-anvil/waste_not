// We start wth only one navigator key, because the bottom navigation bar
// should be present only in the root pages.
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:products_repository/products_repository.dart';

import '../features/features.dart';
import '../widgets/scaffold_with_nested_navigation.dart';
import 'app_route.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _inventoryNavigatorKey = GlobalKey<NavigatorState>();
final _accountNavigatorKey = GlobalKey<NavigatorState>();

// Because child of routes doesn't have a bottom navigation bar, they use
// _rootNavigatorKey as a parentNavigationKey parameter.
final $router = GoRouter(
  // FIXME: use / with redirect.
  initialLocation: '/inventory',
  navigatorKey: _rootNavigatorKey,
  debugLogDiagnostics: true,
  extraCodec: const MyExtraCodec(),
  routes: [
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
          routes: [
            GoRoute(
              path: AppRoute.inventory.rootPath,
              name: AppRoute.inventory.name,
              pageBuilder: (context, state) => const NoTransitionPage(
                child: InventoryPage(),
              ),
              // all children routes
              routes: [
                GoRoute(
                  path: AppRoute.inventoryFilteredBy.path,
                  name: AppRoute.inventoryFilteredBy.name,
                  parentNavigatorKey: _rootNavigatorKey,
                  builder: (context, state) {
                    final filter = ItemStatus.fromValue(
                      state.uri.queryParameters['filter']!,
                    );
                    final cubit = state.extra! as InventoryCubit;
                    return BlocProvider.value(
                      value: cubit,
                      child: InventoryByStatusPage(filter: filter),
                    );
                  },
                ),
                GoRoute(
                  path: AppRoute.scanner.path,
                  name: AppRoute.scanner.name,
                  parentNavigatorKey: _rootNavigatorKey,
                  pageBuilder: (context, state) {
                    return const MaterialPage(
                      fullscreenDialog: true,
                      child: ScannerPage(),
                    );
                  },
                  routes: [
                    GoRoute(
                      path: AppRoute.addProduct.path,
                      name: AppRoute.addProduct.name,
                      parentNavigatorKey: _rootNavigatorKey,
                      builder: (context, state) {
                        final product = state.extra! as ProductEntity;
                        return AddEditItemPage.add(product);
                      },
                    ),
                  ],
                ),
                GoRoute(
                  path: '${AppRoute.editItem.path}/:id',
                  name: AppRoute.editItem.name,
                  parentNavigatorKey: _rootNavigatorKey,
                  builder: (context, state) {
                    final id = state.pathParameters['id']!;
                    return AddEditItemPage.edit(itemId: id);
                  },
                ),
                GoRoute(
                  path: AppRoute.storages.path,
                  name: AppRoute.storages.name,
                  parentNavigatorKey: _rootNavigatorKey,
                  builder: (context, state) => const StoragesPage(),
                  routes: [
                    GoRoute(
                      path: AppRoute.addStorage.path,
                      name: AppRoute.addStorage.name,
                      parentNavigatorKey: _rootNavigatorKey,
                      pageBuilder: (context, state) {
                        return const MaterialPage(
                          fullscreenDialog: true,
                          child: AddEditStoragePage(),
                        );
                      },
                    ),
                    GoRoute(
                      path: AppRoute.editStorage.path,
                      name: AppRoute.editStorage.name,
                      parentNavigatorKey: _rootNavigatorKey,
                      builder: (context, state) {
                        final storageId = state.extra as String?;
                        return AddEditStoragePage(
                          storageId: storageId,
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _accountNavigatorKey,
          routes: [
            GoRoute(
              path: AppRoute.account.rootPath,
              name: AppRoute.account.name,
              pageBuilder: (context, state) => const NoTransitionPage(
                child: AccountPage(),
              ),
            ),
          ],
        ),
      ],
    ),
  ],
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
