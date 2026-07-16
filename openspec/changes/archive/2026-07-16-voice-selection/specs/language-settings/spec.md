## ADDED Requirements

### Requirement: Voice selection section in settings

The Settings screen SHALL include a voice selection section below the language mode section, listing up to 5 prioritised TTS voices with preview playback.

#### Scenario: Settings screen shows voice section
- **WHEN** the caregiver opens the Settings screen
- **THEN** a voice selection section SHALL be visible below the language mode cards
- **THEN** each voice option SHALL be a touch target with minimum 56dp height
- **THEN** each voice option SHALL display the voice name and a play preview button

#### Scenario: Changing language re-evaluates voice list
- **WHEN** the caregiver switches the language mode
- **THEN** the voice list SHALL be refreshed for the new language
- **THEN** if the previously selected voice is unavailable, the first voice SHALL be selected
