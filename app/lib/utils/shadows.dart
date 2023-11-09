import 'package:flutter/material.dart';

abstract class Shadows {
  // 26% of opacity
  static Color color = const Color(0x42000000);

  /// Shadow with color: Color(0x42000000)
  ///
  /// x: 0
  ///
  /// y: 4
  ///
  /// blur: 10
  static BoxShadow shadow1 = BoxShadow(
    color: color,
    offset: const Offset(0, 4),
    blurRadius: 10,
  );

  /// Shadow with color: Color(0x42000000)
  ///
  /// x: 0
  ///
  /// y: 2
  ///
  /// blur: 20
  static BoxShadow shadow2 = BoxShadow(
    color: color,
    blurRadius: 20,
    offset: const Offset(0, 2),
  );

  /// Shadow with color: Color(0x42000000)
  ///
  /// x: 0
  ///
  /// y: 4
  ///
  /// blur: 16.
  /// Used for the bottom bar
  static BoxShadow shadow3 = BoxShadow(
    color: color,
    offset: const Offset(0, 4),
    blurRadius: 16,
  );

  /// Shadow with color: Color(0x30000000)
  ///
  /// x: 0
  ///
  /// y: 5
  ///
  /// blur: 15.
  /// Used for the modal
  static BoxShadow shadow4 = const BoxShadow(
    color: Color(0x30000000),
    offset: Offset(0, 5),
    blurRadius: 15,
  );

  /// Shadow with color: Color(0x42000000)
  ///
  /// x: 4
  ///
  /// y: 0
  ///
  /// blur: 16.
  /// Used for the bottom bar
  static BoxShadow shadowOnRight = BoxShadow(
    color: color,
    offset: const Offset(4, 0),
    blurRadius: 16,
  );
}

class WithShadow extends StatelessWidget {
  const WithShadow({
    required this.child,
    required this.boxShadow,
    super.key,
  });

  final Widget child;

  final List<BoxShadow> boxShadow;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: boxShadow,
      ),
      child: child,
    );
  }
}
