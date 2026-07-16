## Purpose

Allow the caregiver to choose the speech rate from 4 predefined levels, persist the selection, and preview it before confirming.

## ADDED Requirements

### Requirement: Rate levels

The system SHALL provide 4 predefined speech rate levels: Muito Lento (0.25), Lento (0.35), Médio (0.45), and Rápido (0.55).

#### Scenario: Four levels available
- **WHEN** the caregiver inspects the rate options
- **THEN** four levels SHALL be visible: "Muito Lento", "Lento", "Médio", "Rápido"

### Requirement: Default rate

The default speech rate SHALL be "Lento" (0.35) when no preference has been saved.

#### Scenario: Default is Lento
- **WHEN** the app is launched for the first time
- **THEN** the speech rate SHALL be 0.35

### Requirement: Rate persistence

The selected speech rate SHALL be persisted using SharedPreferences and restored on app restart.

#### Scenario: Rate persists across restarts
- **WHEN** the caregiver selects "Muito Lento"
- **THEN** the value 0.25 SHALL be saved to SharedPreferences
- **WHEN** the app restarts
- **THEN** the same rate (0.25) SHALL be restored

### Requirement: Rate applied to speech

The selected speech rate SHALL be applied via `setSpeechRate` before every `speak()` call.

#### Scenario: Speak uses saved rate
- **WHEN** the caregiver selects "Médio" (0.45) and a card is tapped
- **THEN** `setSpeechRate(0.45)` SHALL be called before speaking

### Requirement: Rate outside valid range

If a persisted value falls outside the predefined levels, the system SHALL clamp it to the nearest valid level or fall back to the default.

#### Scenario: Invalid persisted value falls back to Lento
- **WHEN** the app loads a saved rate of 0.0 from a corrupted preference
- **THEN** the system SHALL use 0.35 (Lento)

### Requirement: Rate preview

Each rate option SHALL have a play button that speaks a fixed preview phrase at that rate, using the current voice and language.

#### Scenario: Play button speaks at selected rate
- **WHEN** the caregiver taps the play button next to "Médio"
- **THEN** the system SHALL speak the preview phrase at rate 0.45
