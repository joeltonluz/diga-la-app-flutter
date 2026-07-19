abstract class SettingsRepository {
  Future<String?> getLanguageMode();
  Future<void> setLanguageMode(String mode);

  Future<double?> getSpeechRate();
  Future<void> setSpeechRate(double rate);

  Future<String?> getVoiceName();
  Future<void> setVoiceName(String name);
}
