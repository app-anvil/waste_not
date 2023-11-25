import 'dart:ui';

import 'package:aev_sdk/aev_sdk.dart';

@Deprecated('Colors should be accessed via context theme')
class AppColors {
  @Deprecated('Colors should be accessed via context theme')
  AppColors.light()
      : primary = const Color(0xff3f9a8e),
        textPrimary = const Color(0xff121212),
        background = const Color(0xfff2f2f7),
        textLight = const Color(0xfff2f2f7),
        surface = const Color(0xffffffff);

  @Deprecated('Colors should be accessed via context theme')
  AppColors.dark()
      : primary = const Color(0xff3f9a8e),
        textPrimary = const Color(0xfff2f2f7),
        textLight = const Color(0xfff2f2f7),
        background = const Color(0xff121212),
        surface = const Color(0xff1C1C1C);

  final Color primary;

  final Color background;
  final Color surface;

  final Color textPrimary;
  final Color textLight;
}

extension AppStyleWithColors on AppStyle {
  @Deprecated('Colors should be accessed via context theme')
  SharedColors get sharedColors => const SharedColors();
}

/// This class contains all the colors that are not depending on the theme.
@Deprecated('Colors should be accessed via context theme')
class SharedColors {
  @Deprecated('Colors should be accessed via context theme')
  const SharedColors();

  Color get ok => const Color(0xff3f9a8e);
  Color get warning => const Color(0xfffd8d35);
  Color get alert => const Color(0xffec5c54);
}
