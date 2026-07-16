## Purpose

A grid of cards the user taps to trigger speech output in the active language.

## Requirements

### Requirement: Tap card speaks label

When the user taps a card tile, the system SHALL speak the card's text according to the currently configured language mode (PT, EN, or PT+EN) using the `LanguageService`.

#### Scenario: Tap card triggers language-aware TTS
- **WHEN** the user taps a card tile
- **THEN** the device SHALL play the audio according to the active language mode:
  - **PT mode**: speaks `labelPt` in Brazilian Portuguese
  - **EN mode**: speaks `labelEn` in US English
  - **PT+EN mode**: speaks `labelPt` then `labelEn` in sequence
