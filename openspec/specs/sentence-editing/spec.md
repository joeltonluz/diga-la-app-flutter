## Purpose

Allow the user to reorder cards in the sentence bar and remove specific cards (not just the last card), providing more natural sentence editing in Converse mode.

### Requirement: Reorder cards in sentence bar

The sentence bar SHALL allow the user to reorder cards via move-left/move-right arrow buttons on each mini-card.

#### Scenario: Move-left button reorders card left
- **WHEN** the sentence bar contains two or more cards
- **WHEN** the user taps the left arrow on a card that is not the first
- **THEN** the card SHALL move one position to the left
- **THEN** the remaining cards SHALL shift accordingly

#### Scenario: Move-right button reorders card right
- **WHEN** the sentence bar contains two or more cards
- **WHEN** the user taps the right arrow on a card that is not the last
- **THEN** the card SHALL move one position to the right
- **THEN** the remaining cards SHALL shift accordingly

#### Scenario: First card has no move-left button
- **WHEN** the sentence bar contains cards
- **THEN** the first card SHALL NOT display a left arrow button

#### Scenario: Last card has no move-right button
- **WHEN** the sentence bar contains cards
- **THEN** the last card SHALL NOT display a right arrow button

### Requirement: Remove specific card from sentence

The user SHALL be able to remove any specific card from the sentence bar by tapping it, not just the last card.

#### Scenario: Tap removes specific card
- **WHEN** the sentence bar contains two or more cards
- **WHEN** the user taps a card in the middle of the bar
- **THEN** that specific card SHALL be removed from the sentence
- **THEN** the remaining cards SHALL retain their order

#### Scenario: Remove last card still works
- **WHEN** the sentence bar contains one or more cards
- **WHEN** the user taps the last card in the bar
- **THEN** that card SHALL be removed
- **THEN** the backspace button SHALL still work (removeLast)

### Requirement: SentenceNotifier supports indexed operations

The SentenceNotifier SHALL expose `removeAt(int index)` and `reorder(int oldIndex, int newIndex)` methods in addition to existing `removeLast()` and `clear()`.

#### Scenario: removeAt removes card at index
- **WHEN** `removeAt(0)` is called on a sentence with 3 cards
- **THEN** the first card SHALL be removed
- **THEN** the remaining 2 cards SHALL be in their original relative order

#### Scenario: reorder moves card
- **WHEN** `reorder(0, 2)` is called on a sentence with 3 cards
- **THEN** the card at index 0 SHALL move to index 2
- **THEN** cards at indices 1 and 2 SHALL shift left by one
