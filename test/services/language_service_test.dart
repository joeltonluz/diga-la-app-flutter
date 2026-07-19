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
    test('default mode is pt when no preference saved', () {
      final tts = MockTtsService();
      final settings = InMemorySettingsRepository();
      final service = LanguageService(tts, settings);
      expect(service.currentMode, LanguageMode.pt);
    });
  });

  group('setMode', () {
    test('setMode changes current mode', () async {
      final tts = MockTtsService();
      final settings = InMemorySettingsRepository();
      final service = LanguageService(tts, settings);
      await service.setMode(LanguageMode.en);
      expect(service.currentMode, LanguageMode.en);
    });

    test('setMode persists to SettingsRepository', () async {
      final tts = MockTtsService();
      final settings = InMemorySettingsRepository();
      final service = LanguageService(tts, settings);
      await service.setMode(LanguageMode.en);
      final saved = await settings.getLanguageMode();
      expect(saved, 'en');
    });
  });

  group('speak', () {
    late MockTtsService tts;

    setUp(() {
      tts = MockTtsService();
      when(() => tts.setLanguage(any())).thenAnswer((_) async {});
      when(() => tts.speak(any())).thenAnswer((_) async {});
    });

    test('PT mode calls setLanguage pt-BR and speak labelPt', () async {
      final settings = InMemorySettingsRepository();
      final service = LanguageService(tts, settings);
      await service.speak(card);
      verify(() => tts.setLanguage('pt-BR')).called(1);
      verify(() => tts.speak('água')).called(1);
    });

    test('EN mode calls setLanguage en-US and speak labelEn', () async {
      final settings = InMemorySettingsRepository();
      final service = LanguageService(tts, settings);
      await service.setMode(LanguageMode.en);
      await service.speak(card);
      verify(() => tts.setLanguage('en-US')).called(1);
      verify(() => tts.speak('water')).called(1);
    });
  });

  group('labelFor', () {
    test('PT mode returns labelPt', () {
      final tts = MockTtsService();
      final settings = InMemorySettingsRepository();
      final service = LanguageService(tts, settings);
      expect(service.labelFor(card), 'água');
    });

    test('EN mode returns labelEn', () async {
      final tts = MockTtsService();
      final settings = InMemorySettingsRepository();
      final service = LanguageService(tts, settings);
      await service.setMode(LanguageMode.en);
      expect(service.labelFor(card), 'water');
    });
  });
}
