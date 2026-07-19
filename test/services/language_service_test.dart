import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:diga_la_app/domain/entities/pictogram_card.dart';
import 'package:diga_la_app/services/language_service.dart';
import '../helpers/mocks.dart';

void main() {
  const card = PictogramCard(
    id: 'test',
    labelPt: 'água',
    labelEn: 'water',
    emoji: '💧',
  );

  group('default mode', () {
    test('default app and speech modes are pt when no preference saved', () {
      final tts = MockTtsService();
      final settings = InMemorySettingsRepository();
      final service = LanguageService(tts, settings);
      expect(service.appMode, LanguageMode.pt);
      expect(service.speechMode, LanguageMode.pt);
    });
  });

  group('setAppMode', () {
    test('setAppMode changes app mode', () async {
      final tts = MockTtsService();
      final settings = InMemorySettingsRepository();
      final service = LanguageService(tts, settings);
      await service.setAppMode(LanguageMode.en);
      expect(service.appMode, LanguageMode.en);
    });

    test('setAppMode persists to SettingsRepository', () async {
      final tts = MockTtsService();
      final settings = InMemorySettingsRepository();
      final service = LanguageService(tts, settings);
      await service.setAppMode(LanguageMode.en);
      final saved = await settings.getAppLanguageMode();
      expect(saved, 'en');
    });

    test('setAppMode does not change speechMode', () async {
      final tts = MockTtsService();
      final settings = InMemorySettingsRepository();
      final service = LanguageService(tts, settings);
      await service.setAppMode(LanguageMode.en);
      expect(service.appMode, LanguageMode.en);
      expect(service.speechMode, LanguageMode.pt);
    });
  });

  group('setSpeechMode', () {
    test('setSpeechMode changes speech mode', () async {
      final tts = MockTtsService();
      final settings = InMemorySettingsRepository();
      final service = LanguageService(tts, settings);
      await service.setSpeechMode(LanguageMode.en);
      expect(service.speechMode, LanguageMode.en);
    });

    test('setSpeechMode persists to SettingsRepository', () async {
      final tts = MockTtsService();
      final settings = InMemorySettingsRepository();
      final service = LanguageService(tts, settings);
      await service.setSpeechMode(LanguageMode.en);
      final saved = await settings.getSpeechLanguageMode();
      expect(saved, 'en');
    });

    test('setSpeechMode does not change appMode', () async {
      final tts = MockTtsService();
      final settings = InMemorySettingsRepository();
      final service = LanguageService(tts, settings);
      await service.setSpeechMode(LanguageMode.en);
      expect(service.speechMode, LanguageMode.en);
      expect(service.appMode, LanguageMode.pt);
    });
  });

  group('speak', () {
    late MockTtsService tts;

    setUp(() {
      tts = MockTtsService();
      when(() => tts.setLanguage(any())).thenAnswer((_) async {});
      when(() => tts.speak(any())).thenAnswer((_) async {});
    });

    test('uses speechMode (not appMode) to determine language', () async {
      final settings = InMemorySettingsRepository();
      final service = LanguageService(tts, settings);
      await service.setAppMode(LanguageMode.en);
      expect(service.appMode, LanguageMode.en);
      await service.speak(card);
      verify(() => tts.setLanguage('pt-BR')).called(1);
      verify(() => tts.speak('água')).called(1);
    });

    test('PT speech mode calls setLanguage pt-BR and speak labelPt', () async {
      final settings = InMemorySettingsRepository();
      final service = LanguageService(tts, settings);
      await service.speak(card);
      verify(() => tts.setLanguage('pt-BR')).called(1);
      verify(() => tts.speak('água')).called(1);
    });

    test('EN speech mode calls setLanguage en-US and speak labelEn', () async {
      final settings = InMemorySettingsRepository();
      final service = LanguageService(tts, settings);
      await service.setSpeechMode(LanguageMode.en);
      await service.speak(card);
      verify(() => tts.setLanguage('en-US')).called(1);
      verify(() => tts.speak('water')).called(1);
    });

    test('uses speakPt when available', () async {
      final settings = InMemorySettingsRepository();
      final service = LanguageService(tts, settings);
      const cardWithSpeak = PictogramCard(
        id: 'test',
        labelPt: 'casa',
        labelEn: 'house',
        emoji: '🏠',
        speakPt: 'minha casa',
      );
      await service.speak(cardWithSpeak);
      verify(() => tts.speak('minha casa')).called(1);
    });
  });

  group('labelFor', () {
    test('PT app mode returns labelPt', () {
      final tts = MockTtsService();
      final settings = InMemorySettingsRepository();
      final service = LanguageService(tts, settings);
      expect(service.labelFor(card), 'água');
    });

    test('EN app mode returns labelEn', () async {
      final tts = MockTtsService();
      final settings = InMemorySettingsRepository();
      final service = LanguageService(tts, settings);
      await service.setAppMode(LanguageMode.en);
      expect(service.labelFor(card), 'water');
    });
  });

  group('translate', () {
    test('PT app mode returns Portuguese string', () {
      final tts = MockTtsService();
      final settings = InMemorySettingsRepository();
      final service = LanguageService(tts, settings);
      expect(service.translate('converse'), 'Conversar');
    });

    test('EN app mode returns English string', () async {
      final tts = MockTtsService();
      final settings = InMemorySettingsRepository();
      final service = LanguageService(tts, settings);
      await service.setAppMode(LanguageMode.en);
      expect(service.translate('converse'), 'Converse');
    });
  });
}
