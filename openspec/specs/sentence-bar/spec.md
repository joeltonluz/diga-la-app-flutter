## Purpose

Sentence bar for the Converse mode, allowing the child to chain multiple cards and speak the full sentence in sequence.

## Requirements

### Requirement: Sentence bar exists on ConverseScreen

The ConverseScreen SHALL display a horizontal bar at the top showing the sequence of cards the user has selected. The bar SHALL have a fixed height and scroll horizontally when full.

#### Scenario: Sentence bar is visible
- **WHEN** the user navigates to the ConverseScreen
- **THEN** a horizontal sentence bar SHALL be displayed at the top of the screen
- **THEN** the bar SHALL have a fixed height (the grid below SHALL NOT shift when cards are added or removed)

#### Scenario: Selected card appears in bar
- **WHEN** the user taps a card tile in the grid
- **THEN** that card SHALL appear in the sentence bar
- **THEN** the card's emoji and label SHALL be visible in the bar

### Requirement: Tap card adds to bar (does not speak)

Tapping a card tile in the ConverseScreen grid SHALL add the card to the sentence bar, not speak it directly.

#### Scenario: Tap does not trigger speech
- **WHEN** the user taps a card tile in the ConverseScreen
- **THEN** the system SHALL NOT call `LanguageService.speak()` for that card
- **THEN** the card SHALL be added to the sentence bar instead

### Requirement: Speak button speaks the sentence

A "Speak" button SHALL be available below or next to the sentence bar. When tapped, the system SHALL iterate through each card in the bar in order and call `LanguageService.speak(card)` for each.

#### Scenario: Speak button triggers sequential speech
- **WHEN** the sentence bar contains one or more cards
- **WHEN** the user taps the Speak button
- **THEN** the system SHALL speak each card in the bar in sequence using `LanguageService.speak()` (respecting the configured PT, EN, or PT+EN mode)

### Requirement: Clear button empties the bar

A "Clear" button SHALL be available that removes all cards from the sentence bar at once.

#### Scenario: Clear button empties bar
- **WHEN** the sentence bar contains one or more cards
- **WHEN** the user taps the Clear button
- **THEN** all cards SHALL be removed from the bar
- **THEN** the bar SHALL be empty

### Requirement: Remove last card button

A "Remove last" button SHALL be available that removes only the most recently added card from the sentence bar.

#### Scenario: Remove last card
- **WHEN** the sentence bar contains one or more cards
- **WHEN** the user taps the Remove Last button
- **THEN** only the most recently added card SHALL be removed
- **THEN** the remaining cards SHALL stay in their original order

### Requirement: Fixed card list includes linking words

The fixed card list (`sample_cards.dart`) SHALL include five additional linking words with bilingual labels: eu/I, quero/want, não/not, mais/more, por favor/please. These SHALL be regular `Card` instances like all others.

#### Scenario: Linking words exist
- **WHEN** the app loads sample cards
- **THEN** the list SHALL contain cards for "eu"/"I", "quero"/"want", "não"/"not", "mais"/"more", and "por favor"/"please"

### Requirement: Learn mode is not affected

The LearnScreen SHALL continue to speak cards on tap without any sentence bar. This change SHALL NOT modify any LearnScreen behavior.

#### Scenario: Learn mode still speaks on tap
- **WHEN** the user taps a card in the LearnScreen
- **THEN** the system SHALL continue to call `LanguageService.speak(card)` immediately (no sentence bar involvement)
