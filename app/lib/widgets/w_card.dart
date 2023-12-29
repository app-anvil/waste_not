import 'package:aev_sdk/aev_sdk.dart';
import 'package:flutter/material.dart';

class WCard extends StatelessWidget {
  const WCard({
    required this.child,
    this.onTap,
    this.onLongPress,
    super.key,
  });

  final Widget child;
  final void Function()? onTap;
  final void Function()? onLongPress;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        onLongPress: onLongPress,
        child: Padding(
          padding: $style.insets.card.asPadding,
          child: child,
        ),
      ),
    );
  }
}
