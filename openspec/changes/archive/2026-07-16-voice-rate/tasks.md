## 1. TtsService — speech rate support (TDD)

- [x] 1.1 Write unit tests: default rate is 0.35; `setSpeechRate(0.45)` updates value; `speak()` calls `_tts.setSpeechRate` before speaking (TDD)
- [x] 1.2 Add `double _speechRate` field with default 0.35
- [x] 1.3 Add `double get speechRate` getter
- [x] 1.4 Add `Future<void> setSpeechRate(double rate)` method that delegates to `_tts.setSpeechRate` and stores the value
- [x] 1.5 Update `speak()` to call `_tts.setSpeechRate(_speechRate)` before speaking

## 2. VoiceService — rate persistence (TDD: write tests first)

- [x] 2.1 Write test: default rate returns 0.35 when no preference saved
- [x] 2.2 Write test: `setSpeechRate(0.45)` persists to SharedPreferences
- [x] 2.3 Write test: corrupted persisted value (e.g. 0.0) falls back to 0.35
- [x] 2.4 Write test: after setting rate, `speak()` applies it via TTS mock
- [x] 2.5 Implement rate persistence in VoiceService (load/save SharedPreferences key "speechRate")
- [x] 2.6 Wire `VoiceService` to call `TtsService.setSpeechRate` on init and on change

## 3. Settings screen — rate selection UI

- [x] 3.1 Add rate section header ("Velocidade") below voice section in `settings_screen.dart`
- [x] 3.2 Display 4 rate level cards (Muito Lento / Lento / Médio / Rápido) with radio-style selection and play preview button
- [x] 3.3 Wire play button to speak preview phrase at selected rate
- [x] 3.4 Wire tap on card to select and persist rate
- [x] 3.5 Update settings screen test to verify rate section renders

## 4. Verification

- [x] 4.1 Run all unit tests — confirm all pass (33/33)
- [x] 4.2 Run `flutter analyze` — confirm no new warnings (only pre-existing `undefined_hidden_name` in sentence_bar_test)
- [x] 4.3 Manual test on device: tap each rate level, tap play preview, verify speech speed changes; switch language, verify rate persists
- [x] 4.4 Update main specs: `openspec/specs/language-settings/spec.md` (add rate section), `openspec/specs/voice-rate/spec.md` (new)
