import 'package:flutter/widgets.dart';

/// A way to do dynamic sizing for a horizontally scrolling ListView. The list
/// can have infinite items, but each item should have the same height.
///
/// The idea is to measure one item, let's call it a "prototype". And based on
/// the assumption that all items are the same height, we then set the height
/// of the ListView to match the prototype item.

/// This way, we can avoid having to hardcode any values, and the list can
/// automatically resize when, for example, the user sets a larger font in
/// the system and caused the cards to expand.
///
/// Simply put, the size of a Stack widget, depends on all of its
/// "non-positioned" children. Basically, if a Stack has 3 children, but 2 of
/// which are Positioned, then the Stack will simply match the remaining
/// "non-positioned" child.

/// In this case, I'm using the "prototype item" as one of the non-positioned
/// children, to help the Stack decide its height (which will be the same height
/// as the prototype). Then I'm using a very wide SizedBox to help the Stack
/// decide its width (which will be the same width as the parent's width,
/// typically the device's screen width, because remember: constraints go down,
/// size go up.). I'm also adding an Opacity widget to hide the prototype
/// (this also increases performance by skipping parts of the rendering
/// pipeline), and an IgnorePointer widget to prevent user interactions,
/// in case there are buttons on the prototype item.

/// Next, I'm using a Positioned.fill to make its child (the ListView) match
/// the size of the Stack, which in turn, would match the height of the
/// prototype item, and match the width of the parent. This will be the
/// constraint passed to the ListView, so the ListView will create a
/// "viewport" of that size, which is exactly what we wanted to achieve.
class PrototypeHeight extends StatelessWidget {
  const PrototypeHeight({
    required this.prototype,
    required this.listView,
    super.key,
  });

  final Widget prototype;
  final ListView listView;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        IgnorePointer(
          child: Opacity(
            opacity: 0,
            child: prototype,
          ),
        ),
        const SizedBox(width: double.infinity),
        Positioned.fill(child: listView),
      ],
    );
  }
}
