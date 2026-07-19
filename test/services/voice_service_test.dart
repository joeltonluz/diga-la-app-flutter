import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:diga_la_app/domain/entities/voice.dart';
import 'package:diga_la_app/services/language_service.dart';
import 'package:diga_la_app/services/voice_service.dart';
import '../helpers/mocks.dart';

void main() {
  setUpAll(() {
    registerFallbackValue(const Voice(name: '', locale: ''));
  });

  late MockTtsService mockTts;
  late LanguageService languageService;
  late InMemorySettingsRepository settings;

  setUp(() {
    settings = InMemorySettingsRepository();
    mockTts = MockTtsService();
    languageService = LanguageService(mockTts, settings);

    when(() => mockTts.getVoices()).thenAnswer((_) async => []);
    when(() => mockTts.setVoice(any())).thenAnswer((_) async {});
    when(() => mockTts.setSpeechRate(any())).thenAnswer((_) async {});
    when(() => mockTts.speechRate).thenReturn(0.35);
    when(() => mockTts.speak(any())).thenAnswer((_) async {});
    when(() => mockTts.stop()).thenAnswer((_) async {});
  });

  group('getVoices', () {
    test('filters by pt-BR and returns all with Wavenet first', () async {
      when(() => mockTts.getVoices()).thenAnswer((_) async => [
            const Voice(name: 'pt-BR-Standard-C', locale: 'pt-BR'),
            const Voice(name: 'pt-BR-Standard-A', locale: 'pt-BR'),
            const Voice(name: 'pt-BR-Wavenet-A', locale: 'pt-BR'),
            const Voice(name: 'en-US-Wavenet-A', locale: 'en-US'),
            const Voice(name: 'pt-BR-Wavenet-B', locale: 'pt-BR'),
            const Voice(name: 'pt-BR-Neural-A', locale: 'pt-BR'),
            const Voice(name: 'pt-BR-Standard-B', locale: 'pt-BR'),
          ]);

      final service = VoiceService(mockTts, languageService, settings);
      await service.ready;

      expect(service.voices.length, 6);
      expect(service.voices, everyElement((Voice v) => v.locale == 'pt-BR'));

      expect(service.voices[0].name, 'pt-BR-Wavenet-A');
      expect(service.voices[1].name, 'pt-BR-Wavenet-B');
      expect(service.voices[2].name, 'pt-BR-Neural-A');
      expect(service.voices[3].name, 'pt-BR-Standard-A');
      expect(service.voices[4].name, 'pt-BR-Standard-B');
      expect(service.voices[5].name, 'pt-BR-Standard-C');
    });

    test('returns empty when no voices available', () async {
      when(() => mockTts.getVoices()).thenAnswer((_) async => []);

      final service = VoiceService(mockTts, languageService, settings);
      await service.ready;

      expect(service.voices, isEmpty);
    });
  });

  group('selectVoice', () {
    test('persists voice name to SettingsRepository and sets on TTS', () async {
      when(() => mockTts.getVoices()).thenAnswer((_) async => [
            const Voice(name: 'pt-BR-Wavenet-A', locale: 'pt-BR'),
          ]);
      const voice = Voice(name: 'pt-BR-Wavenet-A', locale: 'pt-BR');
      final service = VoiceService(mockTts, languageService, settings);
      await service.ready;

      await service.selectVoice(voice);

      final saved = await settings.getVoiceName();
      expect(saved, 'pt-BR-Wavenet-A');
      verify(() => mockTts.setVoice(voice)).called(2);
    });
  });

  group('init restore', () {
    test('restores saved voice when it exists in current list', () async {
      settings = InMemorySettingsRepository();
      await settings.setVoiceName('pt-BR-Wavenet-A');
      mockTts = MockTtsService();
      languageService = LanguageService(mockTts, settings);

      when(() => mockTts.getVoices()).thenAnswer((_) async => [
            const Voice(name: 'pt-BR-Standard-A', locale: 'pt-BR'),
            const Voice(name: 'pt-BR-Wavenet-A', locale: 'pt-BR'),
          ]);
      when(() => mockTts.setVoice(any())).thenAnswer((_) async {});
      when(() => mockTts.setSpeechRate(any())).thenAnswer((_) async {});
      when(() => mockTts.speechRate).thenReturn(0.35);
      when(() => mockTts.speak(any())).thenAnswer((_) async {});
      when(() => mockTts.stop()).thenAnswer((_) async {});

      final service = VoiceService(mockTts, languageService, settings);
      await service.ready;

      expect(service.selectedVoice?.name, 'pt-BR-Wavenet-A');
    });

    test('falls back to first voice when saved voice is missing', () async {
      settings = InMemorySettingsRepository();
      await settings.setVoiceName('pt-BR-Wavenet-A');
      mockTts = MockTtsService();
      languageService = LanguageService(mockTts, settings);

      when(() => mockTts.getVoices()).thenAnswer((_) async => [
            const Voice(name: 'pt-BR-Standard-A', locale: 'pt-BR'),
            const Voice(name: 'pt-BR-Standard-B', locale: 'pt-BR'),
          ]);
      when(() => mockTts.setVoice(any())).thenAnswer((_) async {});
      when(() => mockTts.setSpeechRate(any())).thenAnswer((_) async {});
      when(() => mockTts.speechRate).thenReturn(0.35);
      when(() => mockTts.speak(any())).thenAnswer((_) async {});
      when(() => mockTts.stop()).thenAnswer((_) async {});

      final service = VoiceService(mockTts, languageService, settings);
      await service.ready;

      expect(service.selectedVoice?.name, 'pt-BR-Standard-A');
    });
  });

  group('speech rate', () {
    test('default rate is 0.35 when no preference saved', () async {
      when(() => mockTts.getVoices()).thenAnswer((_) async => [
            const Voice(name: 'pt-BR-Wavenet-A', locale: 'pt-BR'),
          ]);

      final service = VoiceService(mockTts, languageService, settings);
      await service.ready;

      expect(service.speechRate, 0.35);
    });

    test('setSpeechRate persists to SettingsRepository', () async {
      when(() => mockTts.getVoices()).thenAnswer((_) async => [
            const Voice(name: 'pt-BR-Wavenet-A', locale: 'pt-BR'),
          ]);
      final service = VoiceService(mockTts, languageService, settings);
      await service.ready;

      await service.setSpeechRate(0.45);

      final saved = await settings.getSpeechRate();
      expect(saved, 0.45);
    });

    test('corrupted persisted value falls back to 0.35', () async {
      settings = InMemorySettingsRepository();
      await settings.setSpeechRate(0.0);
      mockTts = MockTtsService();
      languageService = LanguageService(mockTts, settings);

      when(() => mockTts.getVoices()).thenAnswer((_) async => [
            const Voice(name: 'pt-BR-Wavenet-A', locale: 'pt-BR'),
          ]);
      when(() => mockTts.setVoice(any())).thenAnswer((_) async {});
      when(() => mockTts.setSpeechRate(any())).thenAnswer((_) async {});
      when(() => mockTts.speechRate).thenReturn(0.35);
      when(() => mockTts.speak(any())).thenAnswer((_) async {});
      when(() => mockTts.stop()).thenAnswer((_) async {});

      final service = VoiceService(mockTts, languageService, settings);
      await service.ready;

      expect(service.speechRate, 0.35);
    });

    test('setSpeechRate applies rate via TTS', () async {
      when(() => mockTts.getVoices()).thenAnswer((_) async => [
            const Voice(name: 'pt-BR-Wavenet-A', locale: 'pt-BR'),
          ]);
      final service = VoiceService(mockTts, languageService, settings);
      await service.ready;

      await service.setSpeechRate(0.45);

      verify(() => mockTts.setSpeechRate(0.45)).called(1);
    });
  });
}
