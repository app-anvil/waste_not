// Global helpers for readability
import 'package:app/styles/styles.dart';

AppStyle get $styles => AppStyle();

class AppStyle {
  AppStyle() {
    scale = 1;
  }

  late final double scale;

  /// Padding and margin values
  late final insets = _Insets(scale);

  late final corners = _Corners();

  late final shareColors = SharedColors();
}

class _Insets {
  _Insets(this._scale);

  final double _scale;

  late final double xxs = 4 * _scale;
  late final double xs = 8 * _scale;
  late final double sm = 16 * _scale;
  late final double md = 24 * _scale;
  late final double lg = 32 * _scale;
  late final double xl = 48 * _scale;
  late final double xxl = 56 * _scale;
  late final double offset = 80 * _scale;

  // alias
  late final cardPadding = sm;
}

class _Corners {
  late final double sm = 4;
  late final double md = 8;
  late final double lg = 16;
  late final double xl = 32;
}
