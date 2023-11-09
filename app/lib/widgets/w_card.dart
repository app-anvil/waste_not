import 'package:app/styles/styles.dart';
import 'package:flutter/material.dart';

class WCard extends StatelessWidget {
  const WCard({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all($styles.insets.cardPadding),
        child: child,
      ),
    );
  }
}
