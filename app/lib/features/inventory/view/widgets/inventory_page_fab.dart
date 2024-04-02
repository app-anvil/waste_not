import 'package:a2f_sdk/a2f_sdk.dart';
import 'package:flutter/material.dart';

import '../../../../router/app_route.dart';

class InventoryPageFab extends StatelessWidget {
  const InventoryPageFab({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => context.router.goNamed(AppRoute.scanner.name),
      child: const Icon(Icons.add_rounded),
    );
  }
}
