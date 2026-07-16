## 1. TtsService — expose voice listing and selection

- [x] 1.1 Write unit tests: `getVoices()` returns list from flutter_tts; `setVoice()` calls flutter_tts.setVoice; `currentVoice` returns last set voice (TDD)
- [x] 1.2 Add `Future<List<Voice>> getVoices()` method that delegates to `FlutterTts.getVoices`
- [x] 1.3 Add `Future<void> setVoice(Voice voice)` method that delegates to `FlutterTts.setVoice`
- [x] 1.4 Add `Voice? currentVoice` getter
- [x] 1.5 Update `speak()` to call `setVoice()` before speaking if a voice is configured

## 2. VoiceService — voice logic (TDD: write tests first)

- [x] 2.1 Write test: `getVoices(pt)` filters by pt-BR locale, returns max 5, orders Wavenet/Neural before Standard with deterministic alphabetical fallback (TDD — test before implementation)
- [x] 2.2 Write test: `getVoices(en)` with empty list returns empty
- [x] 2.3 Write test: `selectVoice(name)` persists to SharedPreferences
- [x] 2.4 Write test: on init, if saved voice exists in current list, it is restored
- [x] 2.5 Write test: on init, if saved voice does not exist in current list, falls back to first available (index 0)
- [x] 2.6 Implement `VoiceService` with `getVoices`, `selectVoice`, `previewVoice`, fallback logic
- [x] 2.7 Create Riverpod provider for `VoiceService`

## 3. Settings screen — voice selection UI

- [x] 3.1 Add voice section header below language section in `settings_screen.dart`
- [x] 3.2 Display up to 5 voice options as selectable cards with voice name and play preview button
- [x] 3.3 Wire play button to `VoiceService.previewVoice(voice)` speaking the test phrase
- [x] 3.4 Wire tap on card to `VoiceService.selectVoice(voice)` and update UI
- [x] 3.5 Update settings screen test to verify voice section renders

## 4. Language change — voice re-evaluation

- [x] 4.1 Write test: changing language triggers voice re-evaluation via a listener; saved voice missing in new language falls back to index 0
- [x] 4.2 Wire `LanguageService` mode change to trigger `VoiceService` re-evaluation

## 5. Integration — apply voice globally

- [x] 5.1 Write integration test: after selecting a voice, `LanguageService.speak(card)` uses the selected voice
- [x] 5.2 Wire `VoiceService.applyToTts()` into `LanguageService` so every `speak()` call applies the current voice

## 6. Verification

- [x] 6.1 Run all unit tests — confirm all pass
- [x] 6.2 Run `flutter analyze` — confirm no warnings or errors
- [ ] 6.3 Manual test on device: switch language, verify voice list refreshes; tap play preview; select voice; verify speech uses selected voice *(requires physical device — deferred)*
- [x] 6.4 Update main specs: `openspec/specs/language-settings/spec.md` (add voice section), `openspec/specs/voice-selection/spec.md` (new)
