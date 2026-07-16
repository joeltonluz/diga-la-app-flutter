## Purpose

Allow the caregiver to choose the TTS voice for speech from up to 5 options prioritized by naturalness, and persist the selection on the device.

## ADDED Requirements

### Requirement: Voice listing per language

`VoiceService` SHALL query `flutter_tts` for available voices, filter by the current language locale (`pt-BR` or `en-US`), and return at most 5 voices prioritized deterministically.

#### Scenario: Returns up to 5 voices for current language
- **WHEN** `getVoices(LanguageMode.pt)` is called with a simulated list of 10 pt-BR voices
- **THEN** the result SHALL contain at most 5 entries
- **THEN** the result SHALL only include voices whose locale matches pt-BR

#### Scenario: Returns empty list when no voices available
- **WHEN** `getVoices(LanguageMode.en)` is called with an empty simulated list
- **THEN** the result SHALL be an empty list

### Requirement: Voice prioritization

The voice list SHALL be ordered with higher naturalness/quality first: Wavenet, Neural, Google voices before Standard or Engine-named voices. The ordering SHALL be deterministic.

#### Scenario: Wavenet/Neural voices come first
- **WHEN** the simulated list contains "pt-BR-Standard-A" and "pt-BR-Wavenet-A"
- **THEN** "pt-BR-Wavenet-A" SHALL appear before "pt-BR-Standard-A"

#### Scenario: Alphabetical order for same-tier voices
- **WHEN** two voices share the same quality tier (both "Standard")
- **THEN** they SHALL be ordered alphabetically by name

### Requirement: Voice persistence

The selected voice SHALL be persisted using `SharedPreferences` and restored on app restart.

#### Scenario: Selection persists across restarts
- **WHEN** the caregiver selects voice "pt-BR-Wavenet-A"
- **THEN** `"pt-BR-Wavenet-A"` SHALL be saved to `SharedPreferences`
- **WHEN** the app restarts
- **THEN** the same voice SHALL be restored

### Requirement: Voice fallback on language change

When the caregiver switches language, the voice list SHALL be re-evaluated. If the previously saved voice name does not exist in the new language's list, `VoiceService` SHALL fall back to the first available voice (index 0).

#### Scenario: Saved voice exists in new language — kept
- **WHEN** the language changes from PT to EN and the saved voice "en-US-Neural-A" exists in the EN list
- **THEN** `VoiceService` SHALL keep "en-US-Neural-A" as the active voice

#### Scenario: Saved voice missing in new language — falls back
- **WHEN** the language changes from PT to EN and the saved voice "pt-BR-Wavenet-A" does not exist in the EN list
- **THEN** `VoiceService` SHALL select the first available EN voice

### Requirement: Voice preview

Each voice option SHALL have a play button that speaks a fixed preview phrase in the current language using that specific voice.

#### Scenario: Play button speaks preview
- **WHEN** the caregiver taps the play button next to a voice option
- **THEN** the system SHALL speak "Oi, prazer, estou aqui para te ajudar." (PT) or "Hi, nice to meet you, I'm here to help you." (EN) using that voice

### Requirement: Voices section in settings

The Settings screen SHALL display a voice selection section below the language section, showing up to 5 prioritised voice options as selectable touch targets with a play preview button.

#### Scenario: Voices section visible in settings
- **WHEN** the Settings screen is displayed after voices are loaded
- **THEN** a "Voz" / "Voice" header SHALL be visible below the language section

#### Scenario: Each voice option has a play button
- **WHEN** a voice option is rendered
- **THEN** it SHALL include a play icon button to preview the voice

#### Scenario: Selecting a voice updates the active voice immediately
- **WHEN** the caregiver taps a voice option
- **THEN** the selection SHALL be saved immediately
- **THEN** subsequent speech SHALL use the new voice
