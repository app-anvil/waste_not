import 'package:flutter/material.dart';

import '../../../aev_sdk.dart';

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
        const AppStyle().insets.sm,
        includeTopPadding ? const AppStyle().insets.sm : 0,
        const AppStyle().insets.sm,
        0,
      ),
      child: child,
    );
  }
}
