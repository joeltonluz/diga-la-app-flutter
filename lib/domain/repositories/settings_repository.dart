abstract class SettingsRepository {
  Future<String?> getSpeechLanguageMode();
  Future<void> setSpeechLanguageMode(String mode);

  Future<String?> getAppLanguageMode();
  Future<void> setAppLanguageMode(String mode);

  Future<double?> getSpeechRate();
  Future<void> setSpeechRate(double rate);

  Future<String?> getVoiceName();
  Future<void> setVoiceName(String name);
}
