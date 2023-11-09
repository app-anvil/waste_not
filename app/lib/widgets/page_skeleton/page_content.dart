import 'package:app/styles/styles.dart';
import 'package:flutter/material.dart';

class PageContent extends StatelessWidget {
  const PageContent({
    required this.child,
    this.includeTopPadding = true,
    super.key,
  });

  final Widget child;

  final bool includeTopPadding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        $styles.insets.sm,
        includeTopPadding ? $styles.insets.sm : 0,
        $styles.insets.sm,
        0,
      ),
      child: child,
    );
  }
}
