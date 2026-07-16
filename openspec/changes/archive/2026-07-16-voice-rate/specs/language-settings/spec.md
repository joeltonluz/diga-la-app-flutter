## ADDED Requirements

### Requirement: Rate selection section in settings

The Settings screen SHALL include a speech rate selection section below the voice selection section, showing 4 predefined levels as selectable touch targets with preview playback.

#### Scenario: Settings screen shows rate section
- **WHEN** the caregiver opens the Settings screen
- **THEN** a "Velocidade" / "Speed" section SHALL be visible below the voice cards
- **THEN** each rate option SHALL be a touch target with minimum 56dp height
- **THEN** each rate option SHALL display the level name and a play preview button

#### Scenario: Changing rate updates speech immediately
- **WHEN** the caregiver selects a different rate level
- **THEN** subsequent speech SHALL use the new rate
