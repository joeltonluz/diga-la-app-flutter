import 'dart:math' as math;
import 'package:flutter/material.dart';

Color oklchToColor(double l, double c, double h, {double alpha = 1.0}) {
  final hueRad = h * math.pi / 180;
  final a = c * math.cos(hueRad);
  final b = c * math.sin(hueRad);

  final l_ = l + 0.3963377774 * a + 0.2158037573 * b;
  final m_ = l - 0.1055613458 * a - 0.0638541728 * b;
  final s_ = l - 0.0894841775 * a - 1.2914855480 * b;

  linearToSrgb(double c) {
    if (c > 0.0031308) {
      return 1.055 * math.pow(c, 1.0 / 2.4) - 0.055;
    }
    return c * 12.92;
  }

  final r = linearToSrgb(l_);
  final g = linearToSrgb(m_);
  final b2 = linearToSrgb(s_);

  return Color.from(
    alpha: alpha,
    red: r.clamp(0.0, 1.0),
    green: g.clamp(0.0, 1.0),
    blue: b2.clamp(0.0, 1.0),
  );
}

class DesignTokens {
  DesignTokens._();

  static const fontFamily = 'Nunito';

  static final colors = _DesignColors();
  static final textStyles = _DesignTextStyles();
  static final radii = _DesignRadii();
  static final shadows = _DesignShadows();
  static final spacing = _DesignSpacing();
}

class _DesignColors {
  const _DesignColors();

  Color get backgroundExternal => oklchToColor(0.93, 0.006, 75);
  Color get surfaceScreen => oklchToColor(0.97, 0.012, 75);
  Color get surfaceCard => oklchToColor(0.99, 0.006, 75);
  Color get borderSoft => oklchToColor(0.90, 0.015, 75);
  Color get borderMedium => oklchToColor(0.88, 0.02, 75);
  Color get textPrimary => oklchToColor(0.32, 0.02, 260);
  Color get textPrimaryDark => oklchToColor(0.30, 0.02, 260);
  Color get textSecondary => oklchToColor(0.52, 0.02, 260);
  Color get textSecondaryHigh => oklchToColor(0.55, 0.02, 260);
  Color get brand => oklchToColor(0.72, 0.07, 235);
  Color get brandHover => oklchToColor(0.74, 0.06, 235);
  Color get brandText1 => oklchToColor(0.45, 0.03, 235);
  Color get brandText2 => oklchToColor(0.48, 0.03, 235);
  Color get brandText3 => oklchToColor(0.50, 0.06, 235);
  Color get brandDark => oklchToColor(0.40, 0.09, 235);
  Color get roseSoft => oklchToColor(0.85, 0.06, 15, alpha: 0.75);
  Color get shadow => oklchToColor(0.30, 0.02, 260, alpha: 0.18);
}

class _DesignTextStyles {
  const _DesignTextStyles();

  TextStyle get displayLarge => const TextStyle(
        fontFamily: DesignTokens.fontFamily,
        fontSize: 32,
        fontWeight: FontWeight.w800,
      );

  TextStyle get headlineLarge => const TextStyle(
        fontFamily: DesignTokens.fontFamily,
        fontSize: 24,
        fontWeight: FontWeight.w800,
      );

  TextStyle get headlineMedium => const TextStyle(
        fontFamily: DesignTokens.fontFamily,
        fontSize: 22,
        fontWeight: FontWeight.w700,
      );

  TextStyle get titleLarge => const TextStyle(
        fontFamily: DesignTokens.fontFamily,
        fontSize: 18,
        fontWeight: FontWeight.w700,
      );

  TextStyle get bodyLarge => const TextStyle(
        fontFamily: DesignTokens.fontFamily,
        fontSize: 16,
        fontWeight: FontWeight.w600,
      );

  TextStyle get bodyMedium => const TextStyle(
        fontFamily: DesignTokens.fontFamily,
        fontSize: 15,
        fontWeight: FontWeight.w400,
      );

  TextStyle get bodySmall => const TextStyle(
        fontFamily: DesignTokens.fontFamily,
        fontSize: 13,
        fontWeight: FontWeight.w400,
      );

  TextStyle get labelLarge => const TextStyle(
        fontFamily: DesignTokens.fontFamily,
        fontSize: 20,
        fontWeight: FontWeight.w800,
      );

  TextStyle get cardLabel => const TextStyle(
        fontFamily: DesignTokens.fontFamily,
        fontSize: 17,
        fontWeight: FontWeight.w700,
      );

  TextStyle get button => const TextStyle(
        fontFamily: DesignTokens.fontFamily,
        fontSize: 20,
        fontWeight: FontWeight.w800,
      );

  TextStyle get caption => const TextStyle(
        fontFamily: DesignTokens.fontFamily,
        fontSize: 13,
        fontWeight: FontWeight.w400,
      );
}

class _DesignRadii {
  const _DesignRadii();

  BorderRadius get card => BorderRadius.circular(20);
  BorderRadiusGeometry get button => BorderRadius.circular(22);
  BorderRadius get bar => BorderRadius.circular(24);
  BorderRadius get mini => BorderRadius.circular(14);
}

class _DesignShadows {
  const _DesignShadows();

  List<BoxShadow> get card => [
        BoxShadow(
          color: DesignTokens.colors.shadow,
          blurRadius: 8,
          offset: const Offset(0, 2),
          spreadRadius: 0,
        ),
      ];

  List<BoxShadow> get bar => [
        BoxShadow(
          color: DesignTokens.colors.shadow,
          blurRadius: 6,
          offset: const Offset(0, 1),
          spreadRadius: 0,
        ),
      ];
}

class _DesignSpacing {
  const _DesignSpacing();

  double get xs => 6;
  double get sm => 12;
  double get md => 16;
  double get lg => 24;
  double get xl => 32;
}
