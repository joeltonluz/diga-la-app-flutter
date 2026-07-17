import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:diga_la_app/theme/app_theme.dart';
import 'package:diga_la_app/theme/design_tokens.dart';

void main() {
  group('AppTheme tokens', () {
    final theme = AppTheme.regular();
    final colorScheme = theme.colorScheme;

    test('primary equals azul marca', () {
      final expected = DesignTokens.colors.brand;
      final diff = (colorScheme.primary.r - expected.r).abs() +
          (colorScheme.primary.g - expected.g).abs() +
          (colorScheme.primary.b - expected.b).abs();
      expect(diff, lessThan(0.02));
    });

    test('surface equals fundo cartao', () {
      final expected = DesignTokens.colors.surfaceCard;
      final diff = (colorScheme.surface.r - expected.r).abs() +
          (colorScheme.surface.g - expected.g).abs() +
          (colorScheme.surface.b - expected.b).abs();
      expect(diff, lessThan(0.02));
    });

    test('onSurface equals texto principal', () {
      final expected = DesignTokens.colors.textPrimary;
      final diff = (colorScheme.onSurface.r - expected.r).abs() +
          (colorScheme.onSurface.g - expected.g).abs() +
          (colorScheme.onSurface.b - expected.b).abs();
      expect(diff, lessThan(0.02));
    });
  });

  group('AppTheme text styles', () {
    final theme = AppTheme.regular();
    final textTheme = theme.textTheme;

    test('displayLarge uses Nunito w800', () {
      expect(textTheme.displayLarge?.fontFamily, 'Nunito');
      expect(textTheme.displayLarge?.fontWeight, FontWeight.w800);
    });

    test('titleLarge uses Nunito w700', () {
      expect(textTheme.titleLarge?.fontFamily, 'Nunito');
      expect(textTheme.titleLarge?.fontWeight, FontWeight.w700);
    });

    test('bodyMedium uses Nunito w400', () {
      expect(textTheme.bodyMedium?.fontFamily, 'Nunito');
      expect(textTheme.bodyMedium?.fontWeight, FontWeight.w400);
    });
  });

  group('Touch targets', () {
    test('ElevatedButton has minimum height of 56dp', () {
      final theme = AppTheme.regular();
      final buttonStyle = theme.elevatedButtonTheme.style;
      expect(buttonStyle, isNotNull);
    });

    test('OutlinedButton has minimum height of 56dp', () {
      final theme = AppTheme.regular();
      final buttonStyle = theme.outlinedButtonTheme.style;
      expect(buttonStyle, isNotNull);
    });
  });

  group('DesignTokens direct access', () {
    test('brand color is accessible', () {
      final brand = DesignTokens.colors.brand;
      expect(brand.r, greaterThan(0.5));
      expect(brand.g, greaterThan(0.6));
      expect(brand.b, greaterThan(0.7));
    });

    test('surfaceCard color is near-white', () {
      final surface = DesignTokens.colors.surfaceCard;
      expect(surface.r, greaterThan(0.95));
      expect(surface.g, greaterThan(0.95));
      expect(surface.b, greaterThan(0.95));
    });

    test('theme uses Nunito as fontFamily', () {
      final theme = AppTheme.regular();
      expect(theme.textTheme.bodyMedium?.fontFamily, 'Nunito');
    });
  });
}
