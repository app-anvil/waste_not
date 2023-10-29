import 'package:app/core/core.dart';
import 'package:app/routes/app_route.dart';
import 'package:flutter/material.dart';

class PantryAppBar extends StatelessWidget implements PreferredSizeWidget {
  const PantryAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('Pantry'),
    );
  }

  @override
  Size get preferredSize => AppBar().preferredSize;
}

class PantryFAB extends StatelessWidget {
  const PantryFAB({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => context.router.goNamed(AppRoute.scanner.name),
      child: const Icon(Icons.add_rounded),
    );
  }
}

class PantryPage extends StatelessWidget {
  const PantryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const PantryView();
  }
}

class PantryView extends StatelessWidget {
  const PantryView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
