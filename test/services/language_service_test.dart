import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:diga_la_app/models/card.dart';
import 'package:diga_la_app/services/language_service.dart';
import '../helpers/mocks.dart';

void main() {
  const card = Card(
    id: 'test',
    labelPt: 'água',
    labelEn: 'water',
    emoji: '💧',
  );

  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  group('default mode', () {
    test('default mode is pt when no preference saved', () {
      final tts = MockTtsService();
      final service = LanguageService(tts);
      expect(service.currentMode, LanguageMode.pt);
    });
  });

  group('setMode', () {
    test('setMode changes current mode', () async {
      final tts = MockTtsService();
      final service = LanguageService(tts);
      await service.setMode(LanguageMode.en);
      expect(service.currentMode, LanguageMode.en);
    });

    test('setMode persists to SharedPreferences', () async {
      final tts = MockTtsService();
      final service = LanguageService(tts);
      await service.setMode(LanguageMode.en);
      final prefs = await SharedPreferences.getInstance();
      expect(prefs.getString('languageMode'), 'en');
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
      final service = LanguageService(tts);
      await service.speak(card);
      verify(() => tts.setLanguage('pt-BR')).called(1);
      verify(() => tts.speak('água')).called(1);
    });

    test('EN mode calls setLanguage en-US and speak labelEn', () async {
      final service = LanguageService(tts);
      await service.setMode(LanguageMode.en);
      await service.speak(card);
      verify(() => tts.setLanguage('en-US')).called(1);
      verify(() => tts.speak('water')).called(1);
    });

    test('PT+EN mode speaks both in sequence', () async {
      final service = LanguageService(tts);
      await service.setMode(LanguageMode.ptEn);
      await service.speak(card);
      verifyInOrder([
        () => tts.setLanguage('pt-BR'),
        () => tts.speak('água'),
        () => tts.setLanguage('en-US'),
        () => tts.speak('water'),
      ]);
    });
  });
}
