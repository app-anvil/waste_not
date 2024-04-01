import 'package:a2f_sdk/a2f_sdk.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../styles/app_colors.dart';

ThemeData _buildTheme({
  required Brightness brightness,
  required Color seedColor,
}) {
  // see https://github.com/flutter/flutter/issues/41067
  final theme = ThemeData.from(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: seedColor,
      // color for the textTheme is black if the theme is constructed with
      // Brightness.light
      brightness: brightness,
    ),
  ).copyWith(
    appBarTheme: AppBarTheme(
      systemOverlayStyle: brightness == Brightness.light
          ? SystemUiOverlayStyle.dark
          : SystemUiOverlayStyle.light,
    ),
  );
  const style = AppStyle();
  final col = theme.colorScheme;

  final inputDecorationTheme = theme.inputDecorationTheme.copyWith(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(
        style.corners.sm,
      ),
      borderSide: BorderSide(
        color: col.onPrimary,
        width: 1,
      ),
    ),
  );

  final cardTheme = theme.cardTheme.copyWith(
    margin: EdgeInsets.zero,
    clipBehavior: Clip.hardEdge,
  );

  return theme.copyWith(
    navigationRailTheme: const NavigationRailThemeData(),
    inputDecorationTheme: inputDecorationTheme,
    cardTheme: cardTheme,
  );
}

final _kThemeDark = _buildTheme(
  brightness: Brightness.dark,
  seedColor: const Color(0xff3f9a8e),
);

final _kThemeLight = _buildTheme(
  brightness: Brightness.light,
  seedColor: const Color(0xff3f9a8e),
);

ThemeData getTheme(ThemeMode mode) {
  return mode == ThemeMode.dark ? _kThemeDark : _kThemeLight;
}

class AppTheme {
  AppTheme.light()
      : _isLight = true,
        _colors = AppColors.light();
  AppTheme.dark()
      : _isLight = false,
        _colors = AppColors.dark();

  final bool _isLight;
  final AppColors _colors;

  AppColors get colors => _colors;

  ThemeData get themeData {
    final colorScheme =
        _isLight ? const ColorScheme.light() : const ColorScheme.dark();
    return ThemeData(
      colorScheme: colorScheme.copyWith(
        primary: _colors.primary,
        onBackground: _colors.primary,
        background: _colors.background,
        surface: _colors.surface,
        onSurface: _colors.primary,
      ),
      scaffoldBackgroundColor: _colors.background,
      appBarTheme: AppBarTheme(
        backgroundColor: _colors.background,
        foregroundColor: _colors.textPrimary,
        elevation: 2,
      ),
      cardTheme: CardTheme(
        color: _colors.surface,
        elevation: 1,
        shadowColor: const Color(0x42000000),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular($style.corners.lg),
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        foregroundColor: _colors.surface,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          shape: MaterialStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: $style.corners.card.asBorderRadius,
            ),
          ),
        ),
      ),
    );
  }
}
