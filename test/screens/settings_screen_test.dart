import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:diga_la_app/models/voice.dart';
import 'package:diga_la_app/providers/language_provider.dart';
import 'package:diga_la_app/providers/voice_provider.dart';
import 'package:diga_la_app/screens/settings_screen.dart';
import 'package:diga_la_app/services/language_service.dart';
import 'package:diga_la_app/services/voice_service.dart';
import '../helpers/mocks.dart';

class FakeVoice extends Fake implements Voice {}

MockTtsService createMockTts() {
  final tts = MockTtsService();
  when(() => tts.setLanguage(any())).thenAnswer((_) async {});
  when(() => tts.speak(any())).thenAnswer((_) async {});
  when(() => tts.setSpeechRate(any())).thenAnswer((_) async {});
  when(() => tts.setVoice(any())).thenAnswer((_) async {});
  when(() => tts.stop()).thenAnswer((_) async {});
  when(() => tts.getVoices()).thenAnswer((_) async => <Voice>[]);
  return tts;
}

Widget buildTestApp({
  required LanguageService languageService,
  required VoiceService voiceService,
}) {
  return ProviderScope(
    overrides: [
      languageServiceProvider.overrideWith((ref) => languageService),
      voiceServiceProvider.overrideWith((ref) => voiceService),
    ],
    child: const MaterialApp(
      home: SettingsScreen(),
    ),
  );
}

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
    registerFallbackValue(FakeVoice());
  });

  group('AppBar', () {
    testWidgets('tem título "Configurações" e botão voltar', (tester) async {
      final tts = createMockTts();
      final languageService = LanguageService(tts);
      final voiceService = VoiceService(tts, languageService);

      await tester.pumpWidget(
        buildTestApp(
          languageService: languageService,
          voiceService: voiceService,
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Configurações'), findsOneWidget);
      expect(find.byIcon(Icons.arrow_back_rounded, skipOffstage: false), findsOneWidget);
    });
  });

  group('Cartões de idioma', () {
    testWidgets('Português e English estão visíveis', (tester) async {
      final tts = createMockTts();
      final languageService = LanguageService(tts);
      final voiceService = VoiceService(tts, languageService);

      await tester.pumpWidget(
        buildTestApp(
          languageService: languageService,
          voiceService: voiceService,
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Português'), findsOneWidget);
      expect(find.text('English'), findsOneWidget);
    });

    testWidgets('selecionar Português reflete no estado', (tester) async {
      final tts = createMockTts();
      final languageService = LanguageService(tts);
      final voiceService = VoiceService(tts, languageService);

      await tester.pumpWidget(
        buildTestApp(
          languageService: languageService,
          voiceService: voiceService,
        ),
      );
      await tester.pumpAndSettle();

      // Português deve estar selecionado por padrão
      expect(find.text('Português'), findsOneWidget);

      // Tocar em English
      await tester.tap(find.text('English'));
      await tester.pumpAndSettle();

      // Após tocar, English deve estar selecionado (modo muda)
      expect(languageService.currentMode, LanguageMode.en);
    });
  });

  group('Seção Voz', () {
    testWidgets('existe com botão "Ouvir" para cada voz', (tester) async {
      final tts = createMockTts();
      when(() => tts.getVoices()).thenAnswer(
        (_) async => [
          Voice(name: 'pt-BR-Wavenet-A', locale: 'pt-BR'),
          Voice(name: 'pt-BR-Standard-A', locale: 'pt-BR'),
        ],
      );

      final languageService = LanguageService(tts);
      final voiceService = VoiceService(tts, languageService);
      await voiceService.ready;

      await tester.pumpWidget(
        buildTestApp(
          languageService: languageService,
          voiceService: voiceService,
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Ouvir', skipOffstage: false), findsWidgets);
    });
  });

  group('Seção Velocidade', () {
    testWidgets('controle de velocidade presente', (tester) async {
      final tts = createMockTts();
      final languageService = LanguageService(tts);
      final voiceService = VoiceService(tts, languageService);

      await tester.pumpWidget(
        buildTestApp(
          languageService: languageService,
          voiceService: voiceService,
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('VELOCIDADE DA FALA', skipOffstage: false), findsOneWidget);
      expect(find.byType(Slider, skipOffstage: false), findsOneWidget);
      expect(find.text('Ouvir exemplo', skipOffstage: false), findsOneWidget);
      expect(find.text('Lento', skipOffstage: false), findsOneWidget);
    });
  });
}
