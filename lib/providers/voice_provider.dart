import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/voice_service.dart';
import 'language_provider.dart';

final voiceServiceProvider = ChangeNotifierProvider<VoiceService>((ref) {
  final languageService = ref.read(languageServiceProvider);
  final tts = ref.read(ttsServiceProvider);
  final settings = ref.read(settingsRepositoryProvider);
  return VoiceService(tts, languageService, settings);
});
