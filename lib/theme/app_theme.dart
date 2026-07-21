import 'package:flutter/material.dart';
import 'design_tokens.dart';

class AppTheme {
  AppTheme._();

  static ThemeData regular() {
    const colors = DesignTokens.colors;

    final colorScheme = ColorScheme.light(
      primary: colors.brand,
      onPrimary: colors.surfaceCard,
      secondary: const Color.from(alpha: 1.0, red: 0.851, green: 0.627, blue: 0.627),
      onSecondary: colors.surfaceCard,
      surface: colors.surfaceCard,
      onSurface: colors.textPrimary,
      error: const Color.from(alpha: 1.0, red: 0.729, green: 0.102, blue: 0.102),
      onError: colors.surfaceCard,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      fontFamily: DesignTokens.fontFamily,
      scaffoldBackgroundColor: colors.backgroundExternal,
      textTheme: TextTheme(
        displayLarge: DesignTokens.textStyles.displayLarge,
        headlineLarge: DesignTokens.textStyles.headlineLarge,
        headlineMedium: DesignTokens.textStyles.headlineMedium,
        titleLarge: DesignTokens.textStyles.titleLarge,
        bodyLarge: DesignTokens.textStyles.bodyLarge,
        bodyMedium: DesignTokens.textStyles.bodyMedium,
        bodySmall: DesignTokens.textStyles.bodySmall,
        labelLarge: DesignTokens.textStyles.labelLarge,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colors.brand,
          foregroundColor: colors.surfaceCard,
          minimumSize: const Size(double.infinity, 56),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: DesignTokens.radii.button,
          ),
          textStyle: DesignTokens.textStyles.button,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: colors.brand,
          side: BorderSide(color: colors.brand),
          minimumSize: const Size(double.infinity, 56),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: DesignTokens.radii.button,
          ),
          textStyle: DesignTokens.textStyles.button,
        ),
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: DesignTokens.radii.card,
        ),
        color: colors.surfaceCard,
      ),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );
  }

  static ThemeData highContrast() {
    const colors = DesignTokens.colors;

    final colorScheme = ColorScheme.light(
      primary: colors.hcBrand,
      onPrimary: colors.hcButtonText,
      secondary: colors.hcBrand,
      onSecondary: colors.hcButtonText,
      surface: colors.hcSurface,
      onSurface: colors.hcText,
      error: const Color(0xFFCC0000),
      onError: colors.hcButtonText,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      fontFamily: DesignTokens.fontFamily,
      scaffoldBackgroundColor: colors.hcBackground,
      textTheme: TextTheme(
        displayLarge: DesignTokens.textStyles.displayLarge.copyWith(
          color: colors.hcText,
        ),
        headlineLarge: DesignTokens.textStyles.headlineLarge.copyWith(
          color: colors.hcText,
        ),
        headlineMedium: DesignTokens.textStyles.headlineMedium.copyWith(
          color: colors.hcText,
        ),
        titleLarge: DesignTokens.textStyles.titleLarge.copyWith(
          color: colors.hcText,
        ),
        bodyLarge: DesignTokens.textStyles.bodyLarge.copyWith(
          color: colors.hcText,
        ),
        bodyMedium: DesignTokens.textStyles.bodyMedium.copyWith(
          color: colors.hcText,
        ),
        bodySmall: DesignTokens.textStyles.bodySmall.copyWith(
          color: colors.hcTextSecondary,
        ),
        labelLarge: DesignTokens.textStyles.labelLarge.copyWith(
          color: colors.hcText,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colors.hcBrand,
          foregroundColor: colors.hcButtonText,
          minimumSize: const Size(double.infinity, 56),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: DesignTokens.radii.button,
          ),
          side: const BorderSide(width: 2),
          textStyle: DesignTokens.textStyles.button,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: colors.hcText,
          side: const BorderSide(width: 2),
          minimumSize: const Size(double.infinity, 56),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: DesignTokens.radii.button,
          ),
          textStyle: DesignTokens.textStyles.button,
        ),
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: DesignTokens.radii.card,
        ),
        color: colors.hcSurface,
        surfaceTintColor: Colors.transparent,
      ),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );
  }
}
