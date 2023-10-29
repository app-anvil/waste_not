import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

extension ContextGoRouterExt on BuildContext {
  /// Returns same as GoRouter.of(context).
  GoRouter get router => GoRouter.of(this);

  /// Returns same as GoRouterState.of(context).
  GoRouterState get routerState => GoRouterState.of(this);
}
