import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/card.dart';
import 'tts_service.dart';

enum LanguageMode { pt, en }

class LanguageService extends ChangeNotifier {
  final TtsService _tts;
  LanguageMode _mode = LanguageMode.pt;

  LanguageService(this._tts) {
    _loadSavedMode();
  }

  LanguageMode get currentMode => _mode;

  Future<void> _loadSavedMode() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getString('languageMode') ?? 'pt';
    _mode = LanguageMode.values.firstWhere(
      (m) => m.name == saved,
      orElse: () => LanguageMode.pt,
    );
    notifyListeners();
  }

  Future<void> setMode(LanguageMode mode) async {
    if (mode == _mode) return;
    _mode = mode;
    notifyListeners();
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
    }
  }

  String labelFor(Card card) {
    switch (_mode) {
      case LanguageMode.pt:
        return card.labelPt;
      case LanguageMode.en:
        return card.labelEn;
    }
  }
}
