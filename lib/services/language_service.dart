import 'package:shared_preferences/shared_preferences.dart';
import '../models/card.dart';
import 'tts_service.dart';

enum LanguageMode { pt, en, ptEn }

class LanguageService {
  final TtsService _tts;
  LanguageMode _mode;

  LanguageService(this._tts, this._mode);

  static Future<LanguageService> create(TtsService tts) async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getString('languageMode') ?? 'pt';
    final mode = LanguageMode.values.firstWhere(
      (m) => m.name == saved,
      orElse: () => LanguageMode.pt,
    );
    return LanguageService(tts, mode);
  }

  LanguageMode get currentMode => _mode;

  Future<void> setMode(LanguageMode mode) async {
    _mode = mode;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('languageMode', mode.name);
  }

  Future<void> speak(Card card) async {
    switch (_mode) {
      case LanguageMode.pt:
        await _tts.setLanguage('pt-BR');
        await _tts.speak(card.labelPt);
      case LanguageMode.en:
        await _tts.setLanguage('en-US');
        await _tts.speak(card.labelEn);
      case LanguageMode.ptEn:
        await _tts.setLanguage('pt-BR');
        await _tts.speak(card.labelPt);
        await _tts.setLanguage('en-US');
        await _tts.speak(card.labelEn);
    }
  }
}
