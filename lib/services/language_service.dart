import 'dart:async';

import 'package:flutter/foundation.dart';

import '../domain/entities/pictogram_card.dart';
import '../domain/repositories/settings_repository.dart';
import 'app_strings.dart';
import 'tts_service.dart';

enum LanguageMode { pt, en }

class LanguageService extends ChangeNotifier {
  final TtsService _tts;
  final SettingsRepository _settingsRepository;
  final Completer<void> _ready = Completer<void>();
  LanguageMode _appMode = LanguageMode.pt;
  LanguageMode _speechMode = LanguageMode.pt;

  LanguageService(this._tts, this._settingsRepository) {
    _loadSavedModes().then((_) => _ready.complete());
  }

  Future<void> get ready => _ready.future;
  LanguageMode get appMode => _appMode;
  LanguageMode get speechMode => _speechMode;

  Future<void> _loadSavedModes() async {
    final savedApp = await _settingsRepository.getAppLanguageMode();
    _appMode = LanguageMode.values.firstWhere(
      (m) => m.name == savedApp,
      orElse: () => LanguageMode.pt,
    );
    final savedSpeech = await _settingsRepository.getSpeechLanguageMode();
    _speechMode = LanguageMode.values.firstWhere(
      (m) => m.name == savedSpeech,
      orElse: () => LanguageMode.pt,
    );
    notifyListeners();
  }

  Future<void> setAppMode(LanguageMode mode) async {
    await _ready.future;
    if (mode == _appMode) return;
    _appMode = mode;
    notifyListeners();
    await _settingsRepository.setAppLanguageMode(mode.name);
  }

  Future<void> setSpeechMode(LanguageMode mode) async {
    await _ready.future;
    if (mode == _speechMode) return;
    _speechMode = mode;
    notifyListeners();
    await _settingsRepository.setSpeechLanguageMode(mode.name);
  }

  Future<void> speak(PictogramCard card) async {
    await _ready.future;
    switch (_speechMode) {
      case LanguageMode.pt:
        await _tts.setLanguage('pt-BR');
        await _tts.speak(card.speakPt ?? card.labelPt);
      case LanguageMode.en:
        await _tts.setLanguage('en-US');
        await _tts.speak(card.speakEn ?? card.labelEn);
    }
  }

  String labelFor(PictogramCard card) {
    switch (_appMode) {
      case LanguageMode.pt:
        return card.labelPt;
      case LanguageMode.en:
        return card.labelEn;
    }
  }

  String translate(String key) {
    return AppStrings.get(key, _appMode);
  }
}
