import 'package:flutter_tts/flutter_tts.dart';

class TtsService {
  final FlutterTts _tts;

  TtsService() : _tts = FlutterTts() {
    _tts.setLanguage('pt-BR');
    _tts.setSpeechRate(0.5);
    _tts.setPitch(1.0);
  }

  Future<void> speak(String text) async {
    await _tts.speak(text);
  }

  Future<void> setLanguage(String lang) async {
    await _tts.setLanguage(lang);
  }

  Future<void> stop() async {
    await _tts.stop();
  }
}
