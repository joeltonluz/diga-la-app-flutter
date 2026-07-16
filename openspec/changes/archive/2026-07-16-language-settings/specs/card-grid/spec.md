## MODIFIED Requirements

### Requirement: Tap card speaks label
**FROM:**
When the user taps a card tile, the system SHALL speak the card's label text using the TTS service in Brazilian Portuguese.

#### Scenario: Tap card triggers TTS
- **WHEN** the user taps a card tile
- **THEN** the device SHALL play the audio for that card's label in Brazilian Portuguese

**TO:**
When the user taps a card tile, the system SHALL speak the card's text according to the currently configured language mode (PT, EN, or PT+EN) using the `LanguageService`.

#### Scenario: Tap card triggers language-aware TTS
- **WHEN** the user taps a card tile
- **THEN** the device SHALL play the audio according to the active language mode:
  - **PT mode**: speaks `labelPt` in Brazilian Portuguese
  - **EN mode**: speaks `labelEn` in US English
  - **PT+EN mode**: speaks `labelPt` then `labelEn` in sequence
