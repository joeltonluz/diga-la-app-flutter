## ADDED Requirements

### Requirement: Card data model
The system SHALL define a `Card` model with an `id` (String), `label` (String — the text to speak), and `emoji` (String — the visual representation).

#### Scenario: Card model exists
- **WHEN** the source code is inspected
- **THEN** a `Card` class or data class SHALL exist with fields `id`, `label`, and `emoji`

### Requirement: Fixed list of sample cards
The system SHALL provide a hardcoded list of at least 10 initial cards with labels covering basic communication needs. The cards SHALL include at least: água, comida, banheiro, dormir, brincar, casa, sim, não, quero, acabou.

#### Scenario: Sample cards list exists
- **WHEN** the app is running and the Conversar screen is displayed
- **THEN** the screen SHALL show cards for "água", "comida", "banheiro", "dormir", "brincar", "casa", "sim", "não", "quero", and "acabou"

### Requirement: Card grid on Converse screen
The Converse screen SHALL display cards in a responsive grid layout. The grid SHALL have at least 2 columns.

#### Scenario: Grid is displayed
- **WHEN** the user navigates to the Modo Conversar screen
- **THEN** the placeholder text SHALL NOT be visible
- **THEN** the screen SHALL display cards arranged in a grid with 2 or more columns

### Requirement: Touch target size
Each card tile SHALL have a minimum touch target size of 44x44 dp, with a preference for at least 80x80 dp.

#### Scenario: Card tile is large enough
- **WHEN** a card is rendered on screen
- **THEN** its touchable area SHALL be at least 44x44 dp

### Requirement: Card displays emoji and label
Each card tile SHALL display an emoji (minimum 32 dp) and a text label below it.

#### Scenario: Card tile shows content
- **WHEN** a card tile is rendered
- **THEN** an emoji SHALL be visible inside the tile
- **THEN** the card's label text SHALL be visible below the emoji

### Requirement: Tap card speaks label
When the user taps a card tile, the system SHALL speak the card's label text using the TTS service in Brazilian Portuguese.

#### Scenario: Tap card triggers TTS
- **WHEN** the user taps a card tile
- **THEN** the device SHALL play the audio for that card's label in Brazilian Portuguese

### Requirement: Subtle touch feedback
When a card is tapped, the system SHALL provide a subtle visual feedback (e.g., InkWell splash) without abrupt animations or flashes.

#### Scenario: Touch feedback on tap
- **WHEN** the user taps a card tile
- **THEN** a discreet visual feedback SHALL appear (e.g., ripple or opacity change) with no abrupt animations

### Requirement: Temporary TTS button removed
The temporary TTS test button on the home screen SHALL be removed, as the card grid replaces its validation purpose.

#### Scenario: Temp button no longer visible
- **WHEN** the home screen is displayed
- **THEN** the temporary TTS test button SHALL NOT be present
