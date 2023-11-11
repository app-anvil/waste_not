import 'package:flutter/material.dart';

extension WidgetExt on Widget {
  SliverToBoxAdapter toSliver() => SliverToBoxAdapter(
        child: this,
      );
}
