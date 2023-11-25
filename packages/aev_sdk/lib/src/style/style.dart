import 'package:flutter/material.dart';

import '../widgets/spans.dart';

AppStyle get $style => const AppStyle();

@immutable
class AppStyle {
  const AppStyle();

  /// Rounded edge corner radii
  AppStyleCorners get corners => const AppStyleCorners();

  AppStyleShadows get shadows => const AppStyleShadows();

  /// Padding and margin values
  AppStyleInsets get insets => const AppStyleInsets();

  /// Animation Durations
  AppStyleTimes get times => const AppStyleTimes();

  AppStyleBreakpoints get breakpoints => const AppStyleBreakpoints();
}

@immutable
class AppStyleTimes {
  const AppStyleTimes();
  Duration get fastest => const Duration(milliseconds: 150);
  Duration get fast => const Duration(milliseconds: 300);
  Duration get avg => const Duration(milliseconds: 600);
  Duration get slow => const Duration(milliseconds: 900);
}

@immutable
class AppStyleCorners {
  const AppStyleCorners();
  double get sm => 4;
  double get md => 8;
  double get lg => 32;

  //*****************
  //**** ALIASES ****
  //*****************
  double get card => md;
}

class AppStyleBreakpoints {
  const AppStyleBreakpoints();
  double get max => xl;
  double get min => xs;
  double get xl => 1200;
  double get lg => 992;
  double get md => 768;
  double get sm => 576;
  double get xs => 380;
}

@immutable
class AppStyleInsets {
  const AppStyleInsets();
  double get x3s => 2;
  double get xxs => 4;
  double get xs => 8;
  double get sm => 16;
  double get md => 24;
  double get lg => 32;
  double get xl => 48;
  double get xxl => 56;
  double get offset => 80;

  //*****************
  //**** ALIASES ****
  //*****************
  double get card => md;

  double get screenH => md;
}

@immutable
class AppStyleShadows {
  const AppStyleShadows();
  List<Shadow> get textSoft => [
        Shadow(
          color: Colors.black.withOpacity(.25),
          offset: const Offset(0, 2),
          blurRadius: 4,
        ),
      ];
  List<Shadow> get text => [
        Shadow(
          color: Colors.black.withOpacity(.6),
          offset: const Offset(0, 2),
          blurRadius: 2,
        ),
      ];
  List<Shadow> get textStrong => [
        Shadow(
          color: Colors.black.withOpacity(.6),
          offset: const Offset(0, 4),
          blurRadius: 6,
        ),
      ];
}

extension NumberToWidget on num {
  VSpan get asVSpan => VSpan(toDouble());
  HSpan get asHSpan => HSpan(toDouble());

  EdgeInsets get asPadding => EdgeInsets.all(toDouble());
  EdgeInsets get asPaddingTop => EdgeInsets.only(top: toDouble());
  EdgeInsets get asPaddingBottom => EdgeInsets.only(bottom: toDouble());
  EdgeInsets get asPaddingLeft => EdgeInsets.only(left: toDouble());
  EdgeInsets get asPaddingRight => EdgeInsets.only(right: toDouble());
  EdgeInsets get asPaddingH => EdgeInsets.symmetric(horizontal: toDouble());
  EdgeInsets get asPaddingV => EdgeInsets.symmetric(vertical: toDouble());

  BorderRadius get asBorderRadius => BorderRadius.circular(toDouble());
}
