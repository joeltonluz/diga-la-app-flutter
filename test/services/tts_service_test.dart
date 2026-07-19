import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:diga_la_app/domain/entities/voice.dart';
import 'package:diga_la_app/services/tts_service.dart';
import '../helpers/mocks.dart';

void main() {
  late MockFlutterTts mockFlutterTts;
  late TtsService tts;

  late void Function() onComplete;

  setUp(() {
    mockFlutterTts = MockFlutterTts();
    when(() => mockFlutterTts.setLanguage(any())).thenAnswer((_) async {});
    when(() => mockFlutterTts.setSpeechRate(any())).thenAnswer((_) async {});
    when(() => mockFlutterTts.setPitch(any())).thenAnswer((_) async {});
    when(() => mockFlutterTts.stop()).thenAnswer((_) async {});
    when(() => mockFlutterTts.setVoice(any())).thenAnswer((_) async {});
    when(() => mockFlutterTts.setCompletionHandler(any())).thenAnswer((invocation) {
      onComplete = invocation.positionalArguments[0] as void Function();
    });
    when(() => mockFlutterTts.speak(any())).thenAnswer((_) async {
      onComplete();
    });
    tts = TtsService(tts: mockFlutterTts);
  });

  group('getVoices', () {
    test('returns parsed Voice list from flutter_tts', () async {
      when(() => mockFlutterTts.getVoices).thenAnswer((_) async => [
            {'name': 'pt-BR-Wavenet-A', 'locale': 'pt-BR'},
            {'name': 'pt-BR-Standard-A', 'locale': 'pt-BR'},
          ]);

      final voices = await tts.getVoices();

      expect(voices, [
        const Voice(name: 'pt-BR-Wavenet-A', locale: 'pt-BR'),
        const Voice(name: 'pt-BR-Standard-A', locale: 'pt-BR'),
      ]);
    });

    test('returns empty list when flutter_tts returns null', () async {
      when(() => mockFlutterTts.getVoices).thenAnswer((_) async => null);

      final voices = await tts.getVoices();

      expect(voices, isEmpty);
    });

    test('returns empty list when flutter_tts returns non-List', () async {
      when(() => mockFlutterTts.getVoices).thenAnswer((_) async => 'invalid');

      final voices = await tts.getVoices();

      expect(voices, isEmpty);
    });
  });

  group('setVoice', () {
    test('delegates to flutter_tts.setVoice and updates currentVoice', () async {
      const voice = Voice(name: 'pt-BR-Wavenet-A', locale: 'pt-BR');

      await tts.setVoice(voice);

      verify(() => mockFlutterTts.setVoice({
        'name': 'pt-BR-Wavenet-A',
        'locale': 'pt-BR',
      })).called(1);
      expect(tts.currentVoice, voice);
    });
  });

  group('speech rate', () {
    test('default speech rate is 0.35', () {
      expect(tts.speechRate, 0.35);
    });

    test('setSpeechRate delegates to flutter_tts and stores value', () async {
      await tts.setSpeechRate(0.45);

      verify(() => mockFlutterTts.setSpeechRate(0.45)).called(1);
      expect(tts.speechRate, 0.45);
    });

    test('speak calls setSpeechRate with default rate', () async {
      await tts.speak('água');

      verify(() => mockFlutterTts.setSpeechRate(0.35)).called(1);
      verify(() => mockFlutterTts.speak('água')).called(1);
    });

    test('speak calls setSpeechRate with updated rate after change', () async {
      await tts.setSpeechRate(0.45);
      await tts.speak('água');

      verify(() => mockFlutterTts.setSpeechRate(0.45)).called(2);
      verify(() => mockFlutterTts.speak('água')).called(1);
    });
  });

  group('speak with voice', () {
    test('calls setVoice before speak when a voice is configured', () async {
      const voice = Voice(name: 'pt-BR-Wavenet-A', locale: 'pt-BR');
      await tts.setVoice(voice);

      await tts.speak('água');

      verify(() => mockFlutterTts.setVoice({
        'name': 'pt-BR-Wavenet-A',
        'locale': 'pt-BR',
      })).called(2);
      verify(() => mockFlutterTts.speak('água')).called(1);
    });

    test('speak without configured voice does not call setVoice', () async {
      await tts.speak('água');

      verifyNever(() => mockFlutterTts.setVoice(any()));
      verify(() => mockFlutterTts.speak('água')).called(1);
    });
  });
}
