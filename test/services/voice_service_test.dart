import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:diga_la_app/models/voice.dart';
import 'package:diga_la_app/services/language_service.dart';
import 'package:diga_la_app/services/voice_service.dart';
import '../helpers/mocks.dart';

void main() {
  setUpAll(() {
    registerFallbackValue(const Voice(name: '', locale: ''));
  });
  late MockTtsService mockTts;
  late LanguageService languageService;

  setUp(() {
    SharedPreferences.setMockInitialValues({});
    mockTts = MockTtsService();
    languageService = LanguageService(mockTts);

    when(() => mockTts.getVoices()).thenAnswer((_) async => []);
    when(() => mockTts.setVoice(any())).thenAnswer((_) async {});
    when(() => mockTts.speak(any())).thenAnswer((_) async {});
    when(() => mockTts.stop()).thenAnswer((_) async {});
  });

  group('getVoices', () {
    test('filters by pt-BR and returns max 5 with Wavenet first', () async {
      when(() => mockTts.getVoices()).thenAnswer((_) async => [
            const Voice(name: 'pt-BR-Standard-C', locale: 'pt-BR'),
            const Voice(name: 'pt-BR-Standard-A', locale: 'pt-BR'),
            const Voice(name: 'pt-BR-Wavenet-A', locale: 'pt-BR'),
            const Voice(name: 'en-US-Wavenet-A', locale: 'en-US'),
            const Voice(name: 'pt-BR-Wavenet-B', locale: 'pt-BR'),
            const Voice(name: 'pt-BR-Neural-A', locale: 'pt-BR'),
            const Voice(name: 'pt-BR-Standard-B', locale: 'pt-BR'),
          ]);

      final service = VoiceService(mockTts, languageService);
      await service.ready;

      expect(service.voices.length, lessThanOrEqualTo(5));
      expect(service.voices, everyElement((Voice v) => v.locale == 'pt-BR'));

      expect(service.voices[0].name, 'pt-BR-Wavenet-A');
      expect(service.voices[1].name, 'pt-BR-Wavenet-B');
      expect(service.voices[2].name, 'pt-BR-Neural-A');
      expect(service.voices[3].name, 'pt-BR-Standard-A');
      expect(service.voices[4].name, 'pt-BR-Standard-B');
    });

    test('returns empty when no voices available', () async {
      when(() => mockTts.getVoices()).thenAnswer((_) async => []);

      final service = VoiceService(mockTts, languageService);
      await service.ready;

      expect(service.voices, isEmpty);
    });
  });

  group('selectVoice', () {
    test('persists voice name to SharedPreferences and sets on TTS', () async {
      when(() => mockTts.getVoices()).thenAnswer((_) async => [
            const Voice(name: 'pt-BR-Wavenet-A', locale: 'pt-BR'),
          ]);
      const voice = Voice(name: 'pt-BR-Wavenet-A', locale: 'pt-BR');
      final service = VoiceService(mockTts, languageService);
      await service.ready;

      await service.selectVoice(voice);

      final prefs = await SharedPreferences.getInstance();
      expect(prefs.getString('voiceName'), 'pt-BR-Wavenet-A');
      verify(() => mockTts.setVoice(voice)).called(2);
    });
  });

  group('init restore', () {
    test('restores saved voice when it exists in current list', () async {
      SharedPreferences.setMockInitialValues({'voiceName': 'pt-BR-Wavenet-A'});
      when(() => mockTts.getVoices()).thenAnswer((_) async => [
            const Voice(name: 'pt-BR-Standard-A', locale: 'pt-BR'),
            const Voice(name: 'pt-BR-Wavenet-A', locale: 'pt-BR'),
          ]);

      final service = VoiceService(mockTts, languageService);
      await service.ready;

      expect(service.selectedVoice?.name, 'pt-BR-Wavenet-A');
    });

    test('falls back to first voice when saved voice is missing', () async {
      SharedPreferences.setMockInitialValues({'voiceName': 'pt-BR-Wavenet-A'});
      when(() => mockTts.getVoices()).thenAnswer((_) async => [
            const Voice(name: 'pt-BR-Standard-A', locale: 'pt-BR'),
            const Voice(name: 'pt-BR-Standard-B', locale: 'pt-BR'),
          ]);

      final service = VoiceService(mockTts, languageService);
      await service.ready;

      expect(service.selectedVoice?.name, 'pt-BR-Standard-A');
    });
  });
}
