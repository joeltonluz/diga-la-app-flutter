import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/language_service.dart';
import '../services/tts_service.dart';

final ttsServiceProvider = Provider<TtsService>((ref) {
  return TtsService();
});

final languageServiceProvider = FutureProvider<LanguageService>((ref) async {
  final tts = ref.read(ttsServiceProvider);
  return LanguageService.create(tts);
});
