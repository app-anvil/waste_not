import 'package:app/core/core.dart';
import 'package:app/features/account/account.dart';
import 'package:app/features/pantry/pantry.dart';
import 'package:app/routes/app_route.dart';
import 'package:flutter/material.dart';

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

  PreferredSizeWidget? _buildAppBar(BuildContext context) {
    // I try using matchedLocation, but with material page the location doesn't
    // change. (Go to scanner page from pantry).
    final path = context.routerState.fullPath;
    if (path == AppRoute.pantry.rootPath) {
      return const PantryAppBar();
    } else if (path == AppRoute.account.rootPath) {
      return const AccountAppBar();
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
   
    final state = context.routerState;
    
    return Scaffold(
      appBar: _buildAppBar(context),
      body: body,
      floatingActionButton:
          state.fullPath == AppRoute.pantry.rootPath ? const PantryFAB() : null,
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex,
        destinations: const [
          // products
          NavigationDestination(
            icon: Icon(Icons.home_rounded),
            //selectedIcon:  Icon(Icons.home_rounded),
            // FIXME: [text]
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
            // FIXME: [text]
            label: 'Account',
          ),
        ],
        onDestinationSelected: onDestinationSelected,
      ),
    );
  }
}
