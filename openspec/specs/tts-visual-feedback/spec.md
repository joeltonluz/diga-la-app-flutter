## Purpose

Provide visual feedback during TTS speech so the user can see which card in the sentence is currently being spoken, improving communication clarity for AAC users.

### Requirement: Speaking index tracking

The system SHALL track which card in the sentence is currently being spoken via a `speakingIndexProvider` StateProvider.

#### Scenario: speakingIndex is null initially
- **WHEN** the sentence bar is displayed
- **THEN** `speakingIndex` SHALL be `null`

#### Scenario: speakingIndex updates during speech
- **WHEN** the user taps the Speak button
- **WHEN** the system begins speaking the first card
- **THEN** `speakingIndex` SHALL be set to `0`
- **WHEN** the system finishes speaking the first card and starts the second
- **THEN** `speakingIndex` SHALL update to `1`
- **WHEN** all cards have been spoken
- **THEN** `speakingIndex` SHALL return to `null`

### Requirement: Visual highlight on current card

The mini-card in the sentence bar corresponding to `speakingIndex` SHALL display a visual highlight (animated border and background color change) while the TTS is speaking that card.

#### Scenario: Highlighted card during speech
- **WHEN** `speakingIndex` is `0`
- **THEN** the first mini-card in the sentence bar SHALL display a highlighted state (brand-colored border, tinted background)
- **THEN** all other mini-cards SHALL remain in their default state

#### Scenario: Highlight moves to next card
- **WHEN** `speakingIndex` changes from `0` to `1`
- **THEN** the first mini-card SHALL return to default state
- **THEN** the second mini-card SHALL display the highlighted state

### Requirement: Stop button to interrupt speech

A Stop button SHALL replace the Speak button while TTS is active. Tapping Stop SHALL interrupt the speech immediately.

#### Scenario: Stop button interrupts speech
- **WHEN** TTS is actively speaking
- **WHEN** the user taps the Stop button
- **THEN** TTS SHALL stop immediately
- **THEN** `speakingIndex` SHALL return to `null`
- **THEN** the Stop button SHALL revert to the Speak button

### Requirement: Action buttons disabled during speech

The Speak, Clear, Backspace, Save, and card editing buttons SHALL be disabled while TTS is actively speaking the sentence.

#### Scenario: Buttons disabled during speech
- **WHEN** TTS is actively speaking
- **THEN** the Speak/Stop, Clear, Backspace, Save buttons SHALL be non-interactive (or replaced by Stop)
- **THEN** card taps in the bar SHALL NOT trigger removal
- **THEN** move-left/move-right arrows SHALL NOT be shown
- **WHEN** speech ends
- **THEN** all buttons SHALL return to normal state
