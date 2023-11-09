import 'dart:ui';

class AppColors {
  AppColors.light()
      : primary = const Color(0xff3f9a8e),
        textPrimary = const Color(0xff121212),
        background = const Color(0xfff2f2f7),
        textLight = const Color(0xfff2f2f7),
        surface = const Color(0xffffffff);

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

/// This class contains all the colors that are not depending on the theme.
class SharedColors {
  SharedColors()
      : ok = const Color(0xff3f9a8e),
        warning = const Color(0xfffd8d35),
        alert = const Color(0xffec5c54);

  final Color alert;
  final Color warning;
  final Color ok;
}
