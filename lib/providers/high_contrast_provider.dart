import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _hcStorageKey = 'high_contrast_mode';

final highContrastModeProvider =
    StateNotifierProvider<HighContrastNotifier, bool>((ref) {
  return HighContrastNotifier();
});

class HighContrastNotifier extends StateNotifier<bool> {
  HighContrastNotifier() : super(false) {
    _load();
  }

  Future<void> _load() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      state = prefs.getBool(_hcStorageKey) ?? false;
    } catch (_) {
      state = false;
    }
  }

  Future<void> toggle() async {
    state = !state;
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_hcStorageKey, state);
    } catch (_) {
      // Silently fail if SharedPreferences is unavailable (test environment)
    }
  }
}
