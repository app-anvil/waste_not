import 'package:flutter/material.dart';

class PageScaffold extends StatelessWidget {
  const PageScaffold({
    required this.sliverAppBar,
    required this.child,
    this.fab,
    this.bottomNavigationBar,
    super.key,
  });

  /// This must be a SliverAppBar.
  final Widget sliverAppBar;

  final Widget? fab;

  final Widget? bottomNavigationBar;

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: bottomNavigationBar,
      floatingActionButton: fab,
      body: CustomScrollView(
        primary: true,
        slivers: [
          sliverAppBar,
          SliverFillRemaining(
            child: child,
          ),
        ],
      ),
    );
  }
}
