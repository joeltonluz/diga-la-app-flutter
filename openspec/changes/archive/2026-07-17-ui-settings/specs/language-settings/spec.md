## MODIFIED Requirements

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
