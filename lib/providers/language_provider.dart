import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/repositories/pictogram_repository_impl.dart';
import '../data/repositories/settings_repository_impl.dart';
import '../domain/repositories/pictogram_repository.dart';
import '../domain/repositories/settings_repository.dart';
import '../services/language_service.dart';
import '../services/tts_service.dart';

final ttsServiceProvider = Provider<TtsService>((ref) {
  return TtsService();
});

final settingsRepositoryProvider = Provider<SettingsRepository>((ref) {
  return SettingsRepositoryImpl();
});

final pictogramRepositoryProvider = Provider<PictogramRepository>((ref) {
  return PictogramRepositoryImpl();
});

final languageServiceProvider = ChangeNotifierProvider<LanguageService>((ref) {
  final tts = ref.read(ttsServiceProvider);
  final settings = ref.read(settingsRepositoryProvider);
  return LanguageService(tts, settings);
});
