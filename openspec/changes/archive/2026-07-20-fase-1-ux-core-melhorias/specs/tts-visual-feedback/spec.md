## ADDED Requirements

### Requirement: SentenceNotifier tracks speaking index

The SentenceNotifier SHALL expose a `speakingIndex` field that indicates which card in the sentence is currently being spoken. When no card is being spoken, `speakingIndex` SHALL be `null`.

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

The mini-card in the sentence bar corresponding to `speakingIndex` SHALL display a visual highlight (animated border or background color change) while the TTS is speaking that card.

#### Scenario: Highlighted card during speech
- **WHEN** `speakingIndex` is `0`
- **THEN** the first mini-card in the sentence bar SHALL display a highlighted state (e.g., brand-colored border, slightly larger scale, or bright background)
- **THEN** all other mini-cards SHALL remain in their default state

#### Scenario: Highlight moves to next card
- **WHEN** `speakingIndex` changes from `0` to `1`
- **THEN** the first mini-card SHALL return to default state
- **THEN** the second mini-card SHALL display the highlighted state

### Requirement: Speak button is disabled during speech

The Speak button SHALL be disabled while the TTS is actively speaking the sentence.

#### Scenario: Speak disabled during speech
- **WHEN** the user taps the Speak button
- **WHEN** TTS begins speaking the first card
- **THEN** the Speak button SHALL be disabled (reduced opacity, non-interactive)
- **WHEN** all cards have been spoken
- **THEN** the Speak button SHALL be re-enabled

### Requirement: Stop button to interrupt speech

A Stop button SHALL appear in place of (or alongside) the Speak button while TTS is active. Tapping Stop SHALL interrupt the speech immediately.

#### Scenario: Stop button interrupts speech
- **WHEN** TTS is actively speaking
- **WHEN** the user taps the Stop button
- **THEN** TTS SHALL stop immediately
- **THEN** `speakingIndex` SHALL return to `null`
- **THEN** the Stop button SHALL revert to the Speak button
