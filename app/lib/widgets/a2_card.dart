import 'package:a2f_sdk/a2f_sdk.dart';
import 'package:flutter/material.dart';

class A2Card extends StatelessWidget {
  const A2Card({
    required this.child,
    this.onTap,
    this.onLongPress,
    this.color,
    super.key,
  });

  final Widget child;
  final void Function()? onTap;
  final void Function()? onLongPress;

  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color,
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
