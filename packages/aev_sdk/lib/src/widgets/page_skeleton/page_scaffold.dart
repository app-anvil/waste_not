import 'package:flutter/material.dart';

class PageScaffold extends StatelessWidget {
  const PageScaffold({
    required this.child,
    this.fab,
    this.bottomNavigationBar,
    super.key,
  });

  final Widget? fab;

  final Widget? bottomNavigationBar;

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: bottomNavigationBar,
      floatingActionButton: fab,
      body: child,
      // body: CustomScrollView(
      //   primary: true,
      //   slivers: [
      //     sliverAppBar,
      //     SliverFillRemaining(
      //       child: child,
      //     ),
      //   ],
      // ),
    );
  }
}
