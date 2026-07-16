## Purpose

A grid of cards the user taps to trigger speech output in the active language.

## Requirements

### Requirement: Tap card speaks label

When the user taps a card tile, the system SHALL speak the card's text according to the currently configured language mode (PT or EN) using the `LanguageService`.

#### Scenario: Tap card triggers language-aware TTS
- **WHEN** the user taps a card tile
- **THEN** the device SHALL play the audio according to the active language mode:
  - **PT mode**: speaks `labelPt` in Brazilian Portuguese
  - **EN mode**: speaks `labelEn` in US English

### Requirement: Card display text follows language mode

The text displayed on each card tile SHALL match the currently active language mode.

#### Scenario: Card shows PT text in Portuguese mode
- **WHEN** the language mode is "Português"
- **THEN** every card tile SHALL display its `labelPt`

#### Scenario: Card shows EN text in English mode
- **WHEN** the language mode is "English"
- **THEN** every card tile SHALL display its `labelEn`

#### Scenario: Card text changes immediately on mode switch
- **WHEN** the caregiver changes the language mode in settings
- **THEN** all visible card tiles SHALL update their displayed text immediately
