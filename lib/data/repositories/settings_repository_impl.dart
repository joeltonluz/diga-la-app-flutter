import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/repositories/settings_repository.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  static const _languageModeKey = 'languageMode';
  static const _speechRateKey = 'speechRate';
  static const _voiceNameKey = 'voiceName';

  @override
  Future<String?> getLanguageMode() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_languageModeKey);
  }

  @override
  Future<void> setLanguageMode(String mode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_languageModeKey, mode);
  }

  @override
  Future<double?> getSpeechRate() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getDouble(_speechRateKey);
    if (saved != null && saved >= 0.01 && saved <= 1.0) return saved;
    return null;
  }

  @override
  Future<void> setSpeechRate(double rate) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(_speechRateKey, rate);
  }

  @override
  Future<String?> getVoiceName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_voiceNameKey);
  }

  @override
  Future<void> setVoiceName(String name) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_voiceNameKey, name);
  }
}
