// We start wth only one navigator key, because the bottom navigation bar
// should be present only in the root pages.
import 'package:app/features/account/view/account_page.dart';
import 'package:app/features/pantry/view/pantry_page.dart';
import 'package:app/routes/app_route.dart';
import 'package:app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _pantryNavigatorKey = GlobalKey<NavigatorState>();
final _accountNavigatorKey = GlobalKey<NavigatorState>();

// Because child of routes doesn't have a bottom navigation bar, they use
// _rootNavigatorKey as a parentNavigationKey parameter.
final router = GoRouter(
  initialLocation: '/pantry',
  navigatorKey: _rootNavigatorKey,
  debugLogDiagnostics: true,
  routes: [
    // initial routes with no app bar, e.g. login and sign up routes
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return ScaffoldWithNestedNavigation(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          navigatorKey: _pantryNavigatorKey,
          routes: [
            GoRoute(
              path: AppRoute.pantry.rootPath,
              name: AppRoute.pantry.name,
              pageBuilder: (context, state) => const NoTransitionPage(
                child: PantryPage(),
              ),
              // all children routes
              // routes: const [],
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
              // all children routes
              // routes: const [],
            ),
          ],
        ),
      ],
    ),
  ],
);
