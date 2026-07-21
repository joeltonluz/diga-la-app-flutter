## ADDED Requirements

### Requirement: Category selector in ConverseScreen

The ConverseScreen SHALL display a horizontal scrollable row of category chips above the card grid, allowing the user to browse and select which category's cards appear in the grid.

#### Scenario: Category selector is visible in ConverseScreen
- **WHEN** the user navigates to the ConverseScreen
- **THEN** a horizontal scrollable row of category chips SHALL be displayed between the action buttons row and the card grid
- **THEN** each chip SHALL display the category emoji and name

#### Scenario: Default selection is "Geral"
- **WHEN** the ConverseScreen is first opened
- **THEN** the "Geral" option SHALL be selected by default
- **THEN** the card grid SHALL display the 12 general-purpose cards

#### Scenario: Selecting a category filters the card grid
- **WHEN** the user taps a category chip (e.g., "Animais")
- **THEN** the card grid SHALL display only the cards from that category
- **THEN** the selected chip SHALL be visually highlighted

### Requirement: Add category cards to sentence

Tapping any card in the ConverseScreen grid (from any category) SHALL add it to the sentence bar, just like the general cards.

#### Scenario: Category card adds to sentence
- **WHEN** the user selects a category chip
- **WHEN** the user taps a card from that category in the grid
- **THEN** the card SHALL be added to the sentence bar
- **THEN** the card SHALL behave identically to general cards (reorderable, removable, speakable)

### Requirement: LearnScreen behavior unchanged

The LearnScreen SHALL continue to speak cards on tap without any sentence bar involvement. Category navigation in LearnScreen SHALL remain unaffected.

#### Scenario: LearnScreen unaffected
- **WHEN** the user opens the LearnScreen
- **THEN** the category grid SHALL display as before
- **WHEN** the user taps a card in a category item grid
- **THEN** the system SHALL speak the card via TTS (no sentence bar)
