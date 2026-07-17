## Purpose

Allow the caregiver to choose the speech language mode and persist it on the device.

## Requirements

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

### Requirement: Persistence of language preference

The selected language mode SHALL be persisted on the device and restored when the app restarts.

#### Scenario: Preference survives restart
- **WHEN** the user selects a language mode
- **THEN** the mode SHALL be saved to persistent storage
- **WHEN** the app is closed and reopened
- **THEN** the previously selected mode SHALL be restored

### Requirement: Settings screen

The system SHALL provide a settings screen accessible from the home screen (via an icon) where the caregiver selects the language mode. The options SHALL be displayed as large touch targets (minimum 56dp height) with clear labels and descriptions. The screen SHALL follow the visual system (DesignTokens) instead of raw Theme colors.

#### Scenario: Settings screen is accessible
- **WHEN** the user is on the home screen
- **THEN** an icon SHALL be visible that navigates to the settings screen

#### Scenario: AppBar has back button and title
- **WHEN** the settings screen is displayed
- **THEN** the AppBar SHALL have a circular back button (Icons.arrow_back_rounded) on the left
- **THEN** the title SHALL be "Configurações", centered

#### Scenario: Language cards use brand tokens when selected
- **WHEN** a language option is selected
- **THEN** its card SHALL have DesignTokens.colors.brand border (2px) and a light brand-tinted background
- **WHEN** a language option is not selected
- **THEN** its card SHALL have DesignTokens.colors.borderSoft border (1.5px) and DesignTokens.colors.surfaceCard background
- **THEN** the card SHALL display a flag emoji, title (DesignTokens.textStyles.bodyLarge), and description (DesignTokens.textStyles.bodyMedium in textSecondary)
- **THEN** a radio circle on the right SHALL be filled brand when selected or empty outline (borderSoft) when not

#### Scenario: Language selection is large and clear
- **WHEN** the settings screen is displayed
- **THEN** each language option SHALL be a touch target with minimum 56dp height
- **THEN** each option SHALL display a title and a short description

#### Scenario: Selection is immediate
- **WHEN** the user selects a language option
- **THEN** the preference SHALL be saved immediately
- **THEN** subsequent card taps SHALL use the new mode

### Requirement: Default language mode

The default language mode SHALL be PT (Português) to match the existing behavior before any configuration.

#### Scenario: Default is Portuguese
- **WHEN** the app is launched for the first time
- **THEN** the language mode SHALL default to "Português"

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

### Requirement: Voice selection section in settings

The Settings screen SHALL include a voice selection section below the language mode section, listing up to 5 prioritised TTS voices with preview playback.

#### Scenario: Settings screen shows voice section
- **WHEN** the caregiver opens the Settings screen
- **THEN** a voice selection section SHALL be visible below the language mode cards
- **THEN** each voice option SHALL be a touch target with minimum 56dp height
- **THEN** each voice option SHALL display the voice name and a play preview button

#### Scenario: Changing language re-evaluates voice list
- **WHEN** the caregiver switches the language mode
- **THEN** the voice list SHALL be refreshed for the new language
- **THEN** if the previously selected voice is unavailable, the first voice SHALL be selected

### Requirement: Rate selection section in settings

The Settings screen SHALL include a speech rate selection section below the voice selection section, showing 4 predefined levels as selectable touch targets with preview playback.

#### Scenario: Settings screen shows rate section
- **WHEN** the caregiver opens the Settings screen
- **THEN** a "Velocidade" / "Speed" section SHALL be visible below the voice cards
- **THEN** each rate option SHALL be a touch target with minimum 56dp height
- **THEN** each rate option SHALL display the level name and a play preview button

#### Scenario: Changing rate updates speech immediately
- **WHEN** the caregiver selects a different rate level
- **THEN** subsequent speech SHALL use the new rate
