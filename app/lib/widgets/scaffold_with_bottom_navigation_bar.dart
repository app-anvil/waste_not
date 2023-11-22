import 'package:aev_sdk/aev_sdk.dart';
import 'package:flutter/material.dart';

import '../features/features.dart';
import '../routes/app_route.dart';

class ScaffoldWithBottomNavigationBar extends StatelessWidget {
  const ScaffoldWithBottomNavigationBar({
    required this.body,
    required this.currentIndex,
    required this.onDestinationSelected,
    super.key,
  });
  final Widget body;
  final int currentIndex;
  final ValueChanged<int> onDestinationSelected;

  Widget _buildAppBar(BuildContext context) {
    // I try using matchedLocation, but with material page the location doesn't
    // change. (Go to scanner page from pantry).
    // or use context.router.location()
    final uri = context.routerState.uri.toString();
    if (uri.contains(AppRoute.inventory.rootPath)) {
      return const InventorySliverAppBar();
    } else if (uri.contains(AppRoute.account.rootPath)) {
      return const AccountAppBar();
    }
    throw ArgumentError('Invalid uri root path: $uri');
  }

  // String _buildAppBarTitle(BuildContext context) {
  //   // I try using matchedLocation, but with material page the location doesn't
  //   // change. (Go to scanner page from pantry).
  //   final path = context.routerState.fullPath;
  //   if (path == AppRoute.pantry.rootPath) {
  //     return 'Inventory';
  //   } else if (path == AppRoute.account.rootPath) {
  //     return 'Account';
  //   }
  //   return '';
  // }

  @override
  Widget build(BuildContext context) {
    final state = context.routerState;

    return PageScaffold(
      fab: state.fullPath == AppRoute.inventory.rootPath
          ? const InventoryFAB()
          : null,
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex,
        destinations: const [
          // products
          NavigationDestination(
            icon: Icon(Icons.home_rounded),
            //selectedIcon:  Icon(Icons.home_rounded),
            // FIXME: l10n
            label: 'Pantry',
          ),
          // NavigationDestination(
          //   icon:  Icon(Icons.scanner_rounded),
          //   //selectedIcon:  Icon(Icons.scanner_rounded),
          //   label: 'Scanner',
          // ),
          NavigationDestination(
            icon: Icon(Icons.person_rounded),
            //selectedIcon:  Icon(Icons.shop_rounded),
            // FIXME: l10n
            label: 'Account',
          ),
        ],
        onDestinationSelected: onDestinationSelected,
      ),
      child: body,
    );
  }
}
