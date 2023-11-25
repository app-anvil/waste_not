import 'package:flutter/material.dart';

import '../config/config.dart';

class FlavorBanner extends StatelessWidget {
  const FlavorBanner({
    required this.child,
    required this.flavor,
    super.key,
  });

  final Widget child;
  final Flavor flavor;

  @override
  Widget build(BuildContext context) {
    if (!flavor.show) return child;
    return Stack(
      children: [
        child,
        SizedBox(
          width: 35,
          height: 55,
          child: CustomPaint(
            painter: BannerPainter(
              message: flavor.value,
              textDirection: Directionality.of(context),
              layoutDirection: Directionality.of(context),
              location: BannerLocation.topStart,
              color: const Color(0xFFF9834E),
            ),
          ),
        ),
      ],
    );
  }
}
