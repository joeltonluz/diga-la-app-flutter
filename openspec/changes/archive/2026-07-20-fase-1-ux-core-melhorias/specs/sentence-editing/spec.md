## ADDED Requirements

### Requirement: Reorder cards in sentence bar via drag-and-drop

The sentence bar SHALL allow the user to reorder cards by long-pressing and dragging them to a new position.

#### Scenario: Long-press initiates drag
- **WHEN** the sentence bar contains two or more cards
- **WHEN** the user long-presses a card in the bar
- **THEN** the card SHALL enter a drag state (visual lift effect)
- **THEN** the user SHALL be able to drag the card left or right to a new position

#### Scenario: Drag reorders the sentence
- **WHEN** the user drags a card to a new position in the sentence bar
- **WHEN** the user releases the card
- **THEN** the card SHALL be inserted at the new position
- **THEN** the remaining cards SHALL shift accordingly
- **THEN** the order in the sentence provider SHALL reflect the new arrangement

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
