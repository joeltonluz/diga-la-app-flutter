## ADDED Requirements

### Requirement: Language mode options
The system SHALL support three language modes for speech: Portuguese only (PT), English only (EN), and Portuguese followed by English (PT+EN).

#### Scenario: Three modes exist
- **WHEN** the language configuration is inspected
- **THEN** three options SHALL be available: "Só Português", "Só Inglês", "Português e Inglês"

### Requirement: Language service
The system SHALL provide a `LanguageService` with a method `speak(Card)` that reads the card's `labelPt` and/or `labelEn` depending on the current language mode and calls the TTS with the correct locale.

#### Scenario: PT mode speaks Portuguese
- **WHEN** the language mode is set to "Só Português" and `speak(card)` is called
- **THEN** the system SHALL speak `card.labelPt` in PT-BR

#### Scenario: EN mode speaks English
- **WHEN** the language mode is set to "Só Inglês" and `speak(card)` is called
- **THEN** the system SHALL speak `card.labelEn` in EN-US

#### Scenario: PT+EN mode speaks both
- **WHEN** the language mode is set to "Português e Inglês" and `speak(card)` is called
- **THEN** the system SHALL speak `card.labelPt` in PT-BR followed by `card.labelEn` in EN-US

### Requirement: Persistence of language preference
The selected language mode SHALL be persisted on the device and restored when the app restarts.

#### Scenario: Preference survives restart
- **WHEN** the user selects a language mode
- **THEN** the mode SHALL be saved to persistent storage
- **WHEN** the app is closed and reopened
- **THEN** the previously selected mode SHALL be restored

### Requirement: Settings screen
The system SHALL provide a settings screen accessible from the home screen (via an icon) where the caregiver selects the language mode. The options SHALL be displayed as large touch targets (minimum 56dp height) with clear labels and descriptions.

#### Scenario: Settings screen is accessible
- **WHEN** the user is on the home screen
- **THEN** an icon SHALL be visible that navigates to the settings screen

#### Scenario: Language selection is large and clear
- **WHEN** the settings screen is displayed
- **THEN** each language option SHALL be a touch target with minimum 56dp height
- **THEN** each option SHALL display a title and a short description

#### Scenario: Selection is immediate
- **WHEN** the user selects a language option
- **THEN** the preference SHALL be saved immediately
- **THEN** subsequent card taps SHALL use the new mode

### Requirement: Default language mode
The default language mode SHALL be PT (Só Português) to match the existing behavior before any configuration.

#### Scenario: Default is Portuguese
- **WHEN** the app is launched for the first time
- **THEN** the language mode SHALL default to "Só Português"
