import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:diga_la_app/providers/language_provider.dart';
import 'package:diga_la_app/screens/settings_screen.dart';
import 'package:diga_la_app/services/language_service.dart';
import '../helpers/mocks.dart';

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  testWidgets('settings screen shows two language options', (tester) async {
    final tts = MockTtsService();
    final languageService = LanguageService(tts);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          languageServiceProvider.overrideWith((ref) => languageService),
        ],
        child: const MaterialApp(
          home: SettingsScreen(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Português'), findsOneWidget);
    expect(find.text('English'), findsOneWidget);
  });
}
