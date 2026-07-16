import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/voice.dart';
import 'language_service.dart';
import 'tts_service.dart';

class VoiceService extends ChangeNotifier {
  final TtsService _tts;
  final LanguageService _languageService;
  List<Voice> _allTtsVoices = [];
  List<Voice> _filteredVoices = [];
  Voice? _selectedVoice;
  final Completer<void> _ready = Completer<void>();

  List<Voice> get voices => List.unmodifiable(_filteredVoices);
  Voice? get selectedVoice => _selectedVoice;
  Future<void> get ready => _ready.future;

  VoiceService(this._tts, this._languageService) {
    _languageService.addListener(_onLanguageChanged);
    _init();
  }

  Future<void> _init() async {
    await _loadAndFilter();
    _ready.complete();
  }

  Future<void> _onLanguageChanged() async {
    await _loadAndFilter();
    notifyListeners();
  }

  Future<void> _loadAndFilter() async {
    _allTtsVoices = await _tts.getVoices();
    _filteredVoices = _filterVoices(
      _allTtsVoices,
      _languageService.currentMode,
    );
    await _restoreOrFallback();
  }

  List<Voice> _filterVoices(List<Voice> all, LanguageMode mode) {
    final locale = mode == LanguageMode.pt ? 'pt-BR' : 'en-US';
    final filtered = all.where((v) => v.locale == locale).toList();
    filtered.sort(_compareVoices);
    return filtered.toList();
  }

  int _compareVoices(Voice a, Voice b) {
    final tierA = _voiceTier(a);
    final tierB = _voiceTier(b);
    if (tierA != tierB) return tierA.compareTo(tierB);
    return a.name.compareTo(b.name);
  }

  int _voiceTier(Voice v) {
    final name = v.name.toLowerCase();
    if (name.contains('wavenet')) return 0;
    if (name.contains('neural')) return 1;
    if (name.contains('google')) return 2;
    return 3;
  }

  List<Voice> getVoices(LanguageMode mode) {
    return _filterVoices(_allTtsVoices, mode);
  }

  Future<void> selectVoice(Voice voice) async {
    _selectedVoice = voice;
    await _tts.setVoice(voice);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('voiceName', voice.name);
    notifyListeners();
  }

  Future<void> applyVoice() async {
    if (_selectedVoice != null) {
      await _tts.setVoice(_selectedVoice!);
    }
  }

  Future<void> previewVoice(Voice voice) async {
    final isPt = _languageService.currentMode == LanguageMode.pt;
    final phrase = isPt
        ? 'Oi, prazer, estou aqui para te ajudar.'
        : "Hi, nice to meet you, I'm here to help you.";
    await _tts.setVoice(voice);
    await _tts.speak(phrase);
  }

  Future<void> _restoreOrFallback() async {
    final prefs = await SharedPreferences.getInstance();
    final savedName = prefs.getString('voiceName');

    if (savedName != null) {
      final match = _filteredVoices.where((v) => v.name == savedName);
      if (match.isNotEmpty) {
        _selectedVoice = match.first;
        await _tts.setVoice(_selectedVoice!);
        return;
      }
    }

    if (_filteredVoices.isNotEmpty) {
      _selectedVoice = _filteredVoices.first;
      await _tts.setVoice(_selectedVoice!);
    }
  }
}
