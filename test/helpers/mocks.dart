import 'package:flutter_tts/flutter_tts.dart';
import 'package:mocktail/mocktail.dart';
import 'package:diga_la_app/domain/repositories/settings_repository.dart';
import 'package:diga_la_app/services/tts_service.dart';

class MockTtsService extends Mock implements TtsService {}

class MockFlutterTts extends Mock implements FlutterTts {}

class InMemorySettingsRepository implements SettingsRepository {
  String? _speechLanguageMode;
  String? _appLanguageMode;
  double? _speechRate;
  String? _voiceName;

  @override
  Future<String?> getSpeechLanguageMode() async => _speechLanguageMode;

  @override
  Future<void> setSpeechLanguageMode(String mode) async {
    _speechLanguageMode = mode;
  }

  @override
  Future<String?> getAppLanguageMode() async => _appLanguageMode;

  @override
  Future<void> setAppLanguageMode(String mode) async {
    _appLanguageMode = mode;
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
