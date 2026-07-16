## Why

The current speech rate (0.5) is too fast for the target audience — non-verbal or minimally verbal children who need slow, clear enunciation to associate the spoken word with the visual card. A slower default and caregiver-adjustable control makes the app more accessible.

## What Changes

- **ADD** speech rate preference with a slower default (0.35), persisted via SharedPreferences
- **ADD** a rate selection section in Settings with 4 predefined levels (Muito Lento / Lento / Médio / Rápido) as large touch targets
- **ADD** play preview button per rate level to hear a test phrase before choosing
- **MODIFY** `TtsService` to apply the selected rate before every `speak()` call
- **BREAKING**: none — the new default (0.35) is slower than the current (0.5), changing existing behavior, but it's an improvement

## Capabilities

### New Capabilities
- `voice-rate`: Speech rate selection with predefined levels, persistence, and preview

### Modified Capabilities
- `language-settings`: Settings screen gains a rate section; `TtsService` applies rate before speaking

## Impact

- `lib/services/tts_service.dart`: Add `setSpeechRate(double)`, `speechRate` getter, apply rate in `speak()`
- `lib/services/voice_service.dart`: No changes (rate is independent of voice selection)
- `lib/screens/settings_screen.dart`: Add rate section below voice section
- `test/services/tts_service_test.dart`: Add tests for rate persistence and application
- `test/screens/settings_screen_test.dart`: Update to verify rate section renders
- `openspec/specs/language-settings/spec.md`: Add rate-selection requirement
- `openspec/specs/voice-rate/spec.md` (new): Rate levels, persistence, preview, default
