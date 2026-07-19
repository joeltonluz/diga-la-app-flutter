import 'dart:async';

import 'package:flutter/foundation.dart';

import '../domain/entities/pictogram_card.dart';
import '../domain/repositories/settings_repository.dart';
import 'tts_service.dart';

enum LanguageMode { pt, en }

class LanguageService extends ChangeNotifier {
  final TtsService _tts;
  final SettingsRepository _settingsRepository;
  final Completer<void> _ready = Completer<void>();
  LanguageMode _mode = LanguageMode.pt;

  LanguageService(this._tts, this._settingsRepository) {
    _loadSavedMode().then((_) => _ready.complete());
  }

  Future<void> get ready => _ready.future;
  LanguageMode get currentMode => _mode;

  Future<void> _loadSavedMode() async {
    final saved = await _settingsRepository.getLanguageMode();
    _mode = LanguageMode.values.firstWhere(
      (m) => m.name == saved,
      orElse: () => LanguageMode.pt,
    );
    notifyListeners();
  }

  Future<void> setMode(LanguageMode mode) async {
    await _ready.future;
    if (mode == _mode) return;
    _mode = mode;
    notifyListeners();
    await _settingsRepository.setLanguageMode(mode.name);
  }

  Future<void> speak(PictogramCard card) async {
    await _ready.future;
    switch (_mode) {
      case LanguageMode.pt:
        await _tts.setLanguage('pt-BR');
        await _tts.speak(card.labelPt);
      case LanguageMode.en:
        await _tts.setLanguage('en-US');
        await _tts.speak(card.labelEn);
    }
  }

  String labelFor(PictogramCard card) {
    switch (_mode) {
      case LanguageMode.pt:
        return card.labelPt;
      case LanguageMode.en:
        return card.labelEn;
    }
  }
}
