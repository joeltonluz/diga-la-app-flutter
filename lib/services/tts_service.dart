import 'package:flutter_tts/flutter_tts.dart';
import '../models/voice.dart';

class TtsService {
  final FlutterTts _tts;
  Voice? _currentVoice;

  TtsService({FlutterTts? tts})
      : _tts = tts ?? FlutterTts() {
    _tts.setLanguage('pt-BR');
    _tts.setSpeechRate(0.5);
    _tts.setPitch(1.0);
  }

  Voice? get currentVoice => _currentVoice;

  Future<void> speak(String text) async {
    if (_currentVoice != null) {
      await _tts.setVoice({'name': _currentVoice!.name, 'locale': _currentVoice!.locale});
    }
    await _tts.speak(text);
  }

  Future<void> setLanguage(String lang) async {
    await _tts.setLanguage(lang);
  }

  Future<void> stop() async {
    await _tts.stop();
  }

  Future<List<Voice>> getVoices() async {
    final raw = await _tts.getVoices;
    if (raw == null || raw is! List) return [];
    return raw
        .whereType<Map<dynamic, dynamic>>()
        .map((m) => Voice(
              name: m['name']?.toString() ?? '',
              locale: m['locale']?.toString() ?? '',
            ))
        .toList();
  }

  Future<void> setVoice(Voice voice) async {
    await _tts.setVoice({'name': voice.name, 'locale': voice.locale});
    _currentVoice = voice;
  }
}
