// ignore_for_file: unused_element

import 'package:flutter/material.dart';

extension ContextExt on BuildContext {
  /// Returns same as Theme.of(context).
  ThemeData get theme => Theme.of(this);

  /// Returns same as Theme.of(context).textTheme.
  TextTheme get tt => Theme.of(this).textTheme;

  /// Returns same as Theme.of(context).colorScheme.
  ColorScheme get col => Theme.of(this).colorScheme;

  /// Returns same as Navigator.of(context).
  NavigatorState get nav => Navigator.of(this);

  /// Returns same as Navigator.of(context, rootNavigator: true).
  NavigatorState get navRoot => Navigator.of(this, rootNavigator: true);

  void unfocus() => FocusScope.of(this);
}
