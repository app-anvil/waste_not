import 'package:aev_sdk/aev_sdk.dart';
import 'package:flutter/material.dart';

class WCard extends StatelessWidget {
  const WCard({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: $style.insets.card.asPadding,
        child: child,
      ),
    );
  }
}
