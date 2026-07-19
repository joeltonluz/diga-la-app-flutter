import 'package:flutter_tts/flutter_tts.dart';
import 'package:mocktail/mocktail.dart';
import 'package:diga_la_app/domain/repositories/settings_repository.dart';
import 'package:diga_la_app/services/tts_service.dart';

class MockTtsService extends Mock implements TtsService {}

class MockFlutterTts extends Mock implements FlutterTts {}

class InMemorySettingsRepository implements SettingsRepository {
  String? _languageMode;
  double? _speechRate;
  String? _voiceName;

  @override
  Future<String?> getLanguageMode() async => _languageMode;

  @override
  Future<void> setLanguageMode(String mode) async {
    _languageMode = mode;
  }

  @override
  Future<double?> getSpeechRate() async => _speechRate;

  @override
  Future<void> setSpeechRate(double rate) async {
    _speechRate = rate;
  }

  @override
  Future<String?> getVoiceName() async => _voiceName;

  @override
  Future<void> setVoiceName(String name) async {
    _voiceName = name;
  }
}
