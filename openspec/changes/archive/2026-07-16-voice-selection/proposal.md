## Why

The app speaks using the device's default TTS voice, which may sound robotic or unpleasant — especially for a child who relies on it as their primary communication tool. Caregivers need to pick a voice that is clear, warm, and comfortable for the child to hear daily.

## What Changes

- **ADD** `VoiceService`: a service that queries `flutter_tts` for available voices, filters by the current language, prioritizes up to 5 voices by naturalness/quality, and persists the selection
- **ADD** voice selection section to the Settings screen below the language mode cards
- **MODIFY** `TtsService` to expose voice listing and set the selected voice before speaking
- **MODIFY** `LanguageService` / `TtsService` integration to re-evaluate voice list when language changes and fall back gracefully if the saved voice is not available in the new language
- **BREAKING**: none — fully additive

## Capabilities

### New Capabilities
- `voice-selection`: Listing, filtering, prioritizing, selecting, and persisting the TTS voice per language

### Modified Capabilities
- `language-settings`: Settings screen gains a voice section; language change triggers voice list re-evaluation

## Impact

- `lib/services/tts_service.dart`: Add methods `getVoices()`, `setVoice(String name)`, `currentVoice`
- `lib/services/voice_service.dart` (new): Orchestrates voice listing, filtering, prioritization, persistence
- `lib/providers/voice_provider.dart` (new): Riverpod provider for `VoiceService`
- `lib/screens/settings_screen.dart`: Add voice section below language section
- `lib/providers/language_provider.dart`: May need to trigger voice re-evaluation on language change
- `test/services/voice_service_test.dart` (new): Unit tests for filtering, prioritization, persistence, fallback
- `test/services/tts_service_test.dart` (new or updated): Tests for voice listing/setting
- `openspec/specs/language-settings/spec.md`: Add voice-selection requirements to settings screen
