import 'package:flutter/widgets.dart';

extension WidgetToSliverExtension on Widget {
  SliverToBoxAdapter get asSliver => SliverToBoxAdapter(child: this);

  @Deprecated('Use asSliver instead')
  SliverToBoxAdapter toSliver() => asSliver;
}
