## MODIFIED Requirements

### Requirement: Language mode options

The system SHALL support two language modes for speech and display: Portuguese only (PT) and English only (EN).

#### Scenario: Two modes exist
- **WHEN** the language configuration is inspected
- **THEN** two options SHALL be available: "Português" and "English"

### Requirement: Language service

The system SHALL provide a `LanguageService` with a method `speak(Card)` that reads the card's `labelPt` or `labelEn` depending on the current language mode and calls the TTS with the correct locale.

#### Scenario: PT mode speaks Portuguese
- **WHEN** the language mode is set to "Português" and `speak(card)` is called
- **THEN** the system SHALL speak `card.labelPt` in PT-BR

#### Scenario: EN mode speaks English
- **WHEN** the language mode is set to "English" and `speak(card)` is called
- **THEN** the system SHALL speak `card.labelEn` in EN-US

## ADDED Requirements

### Requirement: Card text resolution

The system SHALL provide a method `labelFor(Card)` on `LanguageService` that returns the card text appropriate for the current language mode.

#### Scenario: PT mode returns labelPt
- **WHEN** the language mode is "Português" and `labelFor(card)` is called
- **THEN** the system SHALL return `card.labelPt`

#### Scenario: EN mode returns labelEn
- **WHEN** the language mode is "English" and `labelFor(card)` is called
- **THEN** the system SHALL return `card.labelEn`

### Requirement: Persistence fallback for removed mode

The system SHALL handle persisted preferences for the removed PT+EN mode by falling back to PT.

#### Scenario: Persisted ptEn falls back to pt
- **WHEN** the app loads a saved preference of `"ptEn"` from a previous version
- **THEN** the system SHALL use Portuguese (PT) mode

## REMOVED Requirements

### Requirement: Language mode options (PT+EN mode)

**Reason**: The PT+EN mode has been removed to simplify the language model. Card text now follows the selected language, making bilingual speech unnecessary.

**Migration**: Users who had PT+EN selected will now default to Portuguese (PT). The third option is no longer displayed in settings.

#### Scenario: PT+EN mode speaks both
- **WHEN** the language mode was set to "Português e Inglês"
- **THEN** this mode no longer exists

### Requirement: Language service (PT+EN speak)

**Reason**: The PT+EN speech mode has been removed.

**Migration**: The `speak()` method no longer handles the `ptEn` case.
