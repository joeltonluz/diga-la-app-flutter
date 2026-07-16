## Purpose

Resolve card display text according to the currently active language mode.

## ADDED Requirements

### Requirement: LanguageService.labelFor

`LanguageService` SHALL provide a `String labelFor(Card card)` method that returns the card's text in the currently active language.

#### Scenario: Returns labelPt in PT mode
- **WHEN** the current mode is `LanguageMode.pt` and `labelFor(card)` is called
- **THEN** it SHALL return `card.labelPt`

#### Scenario: Returns labelEn in EN mode
- **WHEN** the current mode is `LanguageMode.en` and `labelFor(card)` is called
- **THEN** it SHALL return `card.labelEn`

### Requirement: CardTile and MiniCard accept resolved label

Card display widgets SHALL accept an explicit label string rather than resolving language internally, keeping them stateless and testable.

#### Scenario: CardTile displays provided label
- **WHEN** a `CardTile` is created with a `label` parameter
- **THEN** it SHALL display that text below the emoji instead of `card.label`

#### Scenario: SentenceBar MiniCard displays provided label
- **WHEN** a `_MiniCard` is created with a resolved label
- **THEN** it SHALL display that text below the emoji instead of `card.label`
