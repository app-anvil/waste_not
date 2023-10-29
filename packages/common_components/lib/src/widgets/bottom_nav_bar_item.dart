import 'package:flutter/material.dart';

/// {@template bottom_nav_bar_item} Representation of a tab item in a
/// ScaffoldWithBottomNavBar.
///
/// The app does use the material 3 navigation bar style, so it extends
/// [BottomNavigationBarItem] instead of the NavigationDestination.
/// {@endtemplate}
class BottomNavBarItem extends BottomNavigationBarItem {
  /// {@macro bottom_nav_bar_item} Constructs an [BottomNavBarItem]
  BottomNavBarItem({
    required this.rootRoutePath,
    required this.navigatorKey,
    required super.icon,
  });

  /// The initial location/path
  final String rootRoutePath;

  /// Optional navigatorKey
  final GlobalKey<NavigatorState> navigatorKey;
}
