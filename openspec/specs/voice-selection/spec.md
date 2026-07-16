## Purpose

Allow the caregiver to choose the TTS voice for speech from up to 5 options prioritized by naturalness, and persist the selection on the device.

## Requirements

### Requirement: Voice listing per language

`VoiceService` SHALL query `flutter_tts` for available voices, filter by the current language locale (`pt-BR` or `en-US`), and return at most 5 voices prioritized deterministically.

#### Scenario: Returns up to 5 voices for current language
- **WHEN** `getVoices(LanguageMode.pt)` is called with available pt-BR voices
- **THEN** the result SHALL contain at most 5 entries
- **THEN** the result SHALL only include voices whose locale matches pt-BR

#### Scenario: Returns empty list when no voices available
- **WHEN** `getVoices(LanguageMode.en)` is called and no voices are available
- **THEN** the result SHALL be an empty list

### Requirement: Voice prioritization

The voice list SHALL be ordered with higher naturalness/quality first: Wavenet, Neural, Google voices before Standard or engine-named voices. The ordering SHALL be deterministic.

#### Scenario: Wavenet/Neural voices come first
- **WHEN** the available voices include both "pt-BR-Standard-A" and "pt-BR-Wavenet-A"
- **THEN** "pt-BR-Wavenet-A" SHALL appear before "pt-BR-Standard-A"

#### Scenario: Alphabetical order for same-tier voices
- **WHEN** two voices share the same quality tier
- **THEN** they SHALL be ordered alphabetically by name

### Requirement: Voice persistence

The selected voice SHALL be persisted using `SharedPreferences` and restored on app restart.

#### Scenario: Selection persists across restarts
- **WHEN** the caregiver selects a voice
- **THEN** the voice name SHALL be saved to `SharedPreferences`
- **WHEN** the app restarts
- **THEN** the same voice SHALL be restored

### Requirement: Voice fallback on language change

When the caregiver switches language, the voice list SHALL be re-evaluated. If the previously saved voice name does not exist in the new language's list, `VoiceService` SHALL fall back to the first available voice.

#### Scenario: Saved voice exists in new language
- **WHEN** the language changes and the saved voice exists in the new list
- **THEN** the saved voice SHALL remain selected

#### Scenario: Saved voice missing in new language
- **WHEN** the language changes and the saved voice does not exist in the new list
- **THEN** the first available voice SHALL be selected

### Requirement: Voice preview

Each voice option SHALL have a play button that speaks a fixed preview phrase in the current language using that specific voice.

#### Scenario: Play button speaks preview
- **WHEN** the caregiver taps the play button next to a voice option
- **THEN** the system SHALL speak "Oi, prazer, estou aqui para te ajudar." (PT) or "Hi, nice to meet you, I'm here to help you." (EN) using that voice
