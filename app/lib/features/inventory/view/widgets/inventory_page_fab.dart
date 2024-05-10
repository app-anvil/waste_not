import 'package:flutter/material.dart';

import '../../../scanner/scanner.dart';

class InventoryPageFab extends StatelessWidget {
  const InventoryPageFab({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => ScannerPage.push(context),
      child: const Icon(Icons.add_rounded),
    );
  }
}
