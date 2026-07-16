## ADDED Requirements

### Requirement: Card model unit tests

The `Card` model SHALL have unit tests verifying that `labelPt`, `labelEn`, `emoji`, and `label` (defaults to `labelPt`) are correctly exposed.

#### Scenario: Card exposes bilingual labels
- **WHEN** a Card is instantiated with `labelPt` and `labelEn`
- **THEN** `labelPt` SHALL return the Portuguese text
- **THEN** `labelEn` SHALL return the English text
- **THEN** `label` SHALL return the Portuguese text by default

### Requirement: LanguageService unit tests

The `LanguageService` SHALL have unit tests verifying:
- Default mode is `pt`
- `setMode()` changes the current mode
- `setMode()` persists the choice via `SharedPreferences`
- `speak()` calls `TtsService.setLanguage()` and `.speak()` with the correct locale and label for each mode (pt, en, ptEn)
- Loaded preference from storage is restored on initialization

#### Scenario: Default mode is Portuguese
- **WHEN** a LanguageService is created without prior saved preference
- **THEN** `currentMode` SHALL be `LanguageMode.pt`

#### Scenario: setMode changes current mode
- **WHEN** `setMode(LanguageMode.en)` is called
- **THEN** `currentMode` SHALL be `LanguageMode.en`

#### Scenario: setMode persists preference
- **WHEN** `setMode(LanguageMode.en)` is called
- **THEN** the value SHALL be saved to `SharedPreferences` under key `languageMode`

#### Scenario: speak in PT mode uses pt-BR and labelPt
- **GIVEN** `currentMode` is `LanguageMode.pt`
- **WHEN** `speak(card)` is called
- **THEN** `TtsService.setLanguage('pt-BR')` SHALL be called
- **THEN** `TtsService.speak(card.labelPt)` SHALL be called

#### Scenario: speak in EN mode uses en-US and labelEn
- **GIVEN** `currentMode` is `LanguageMode.en`
- **WHEN** `speak(card)` is called
- **THEN** `TtsService.setLanguage('en-US')` SHALL be called
- **THEN** `TtsService.speak(card.labelEn)` SHALL be called

#### Scenario: speak in PT+EN mode speaks both in sequence
- **GIVEN** `currentMode` is `LanguageMode.ptEn`
- **WHEN** `speak(card)` is called
- **THEN** `TtsService.setLanguage('pt-BR')` SHALL be called first
- **THEN** `TtsService.speak(card.labelPt)` SHALL be called
- **THEN** `TtsService.setLanguage('en-US')` SHALL be called
- **THEN** `TtsService.speak(card.labelEn)` SHALL be called

### Requirement: Sentence bar widget tests

The `SentenceBar` widget SHALL have widget tests verifying:
- Empty bar displays placeholder text
- Bar with cards displays mini card widgets

#### Scenario: Empty bar shows placeholder
- **WHEN** the SentenceBar is rendered with an empty list
- **THEN** placeholder text SHALL be visible

#### Scenario: Bar with cards shows mini cards
- **WHEN** the SentenceBar is rendered with a non-empty list
- **THEN** each card's emoji SHALL be visible
- **THEN** each card's label SHALL be visible

### Requirement: Settings screen widget test

The `SettingsScreen` SHALL have a widget test verifying that the three language options are displayed.

#### Scenario: Settings shows three language options
- **WHEN** the SettingsScreen is rendered
- **THEN** the title "Português" SHALL be visible
- **THEN** the title "English" SHALL be visible
- **THEN** the title "Português + English" SHALL be visible

### Requirement: Test infrastructure

The test infrastructure SHALL support mocking of `TtsService` and `FlutterTts` using `mocktail`, with no code generation required.

#### Scenario: Mocked TtsService is available
- **WHEN** a test creates a `MockTtsService`
- **THEN** it SHALL be substitutable for `TtsService` in `LanguageService`
