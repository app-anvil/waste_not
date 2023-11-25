import 'package:aev_sdk/aev_sdk.dart';
import 'package:flutter/material.dart';

import '../styles/app_colors.dart';

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
