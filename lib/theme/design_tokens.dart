import 'package:flutter/material.dart';

class DesignTokens {
  DesignTokens._();

  static const fontFamily = 'Nunito';

  static const colors = _DesignColors();
  static const textStyles = _DesignTextStyles();
  static const radii = _DesignRadii();
  static const shadows = _DesignShadows();
  static const spacing = _DesignSpacing();
}

class _DesignColors {
  const _DesignColors();

  Color get backgroundExternal => const Color(0xFFEAE7E3);
  Color get surfaceScreen => const Color(0xFFFAF4EC);
  Color get surfaceCard => const Color(0xFFFEFBF7);
  Color get borderSoft => const Color(0xFFE4DDD3);
  Color get borderMedium => const Color(0xFFDFD6C9);
  Color get textPrimary => const Color(0xFF2D333D);
  Color get textPrimaryDark => const Color(0xFF282E38);
  Color get textSecondary => const Color(0xFF626975);
  Color get textSecondaryHigh => const Color(0xFF6B727E);
  Color get brand => const Color(0xFF79ACCB);
  Color get brandHover => const Color(0xFF86B2CC);
  Color get brandText1 => const Color(0xFF455864);
  Color get brandText2 => const Color(0xFF4D616C);
  Color get brandText3 => const Color(0xFF406981);
  Color get brandDark => const Color(0xFF004E71);
  Color get roseSoft => const Color(0xBFF3BEC1);
  Color get shadow => const Color(0x2E282E38);
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
    ),
  ];

  List<BoxShadow> get bar => [
    BoxShadow(
      color: DesignTokens.colors.shadow,
      blurRadius: 6,
      offset: const Offset(0, 1),
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
