## Purpose

Provide an optional high-contrast visual theme for users with low vision or high sensitivity to low-contrast interfaces, improving accessibility.

### Requirement: High contrast theme implementation

The `AppTheme.highContrast()` method SHALL return a `ThemeData` with true high-contrast colors, distinct from the regular theme.

#### Scenario: High contrast uses different colors
- **WHEN** `AppTheme.highContrast()` is called
- **THEN** the returned theme SHALL use high-contrast colors (white background, black text, blue brand)
- **THEN** borders SHALL be thicker (minimum 2px) than the regular theme
- **THEN** all touch targets SHALL maintain minimum 56dp

### Requirement: High contrast toggle in Settings

The SettingsScreen SHALL include a toggle to enable or disable high contrast mode. The toggle SHALL have a clear label and description.

#### Scenario: High contrast toggle is visible
- **WHEN** the user opens the Settings screen
- **THEN** a high contrast toggle SHALL be displayed below the existing settings sections
- **THEN** the toggle SHALL display a label ("Alto Contraste" / "High Contrast") and description

#### Scenario: Toggle switches theme immediately
- **WHEN** the user enables high contrast mode
- **THEN** the app theme SHALL switch to high contrast immediately
- **WHEN** the user disables high contrast mode
- **THEN** the app theme SHALL revert to the regular theme immediately

### Requirement: Persistence of high contrast preference

The high contrast preference SHALL be persisted on the device and restored when the app restarts.

#### Scenario: High contrast survives restart
- **WHEN** the user enables high contrast mode
- **WHEN** the app is closed and reopened
- **THEN** the app SHALL display in high contrast mode

### Requirement: High contrast provider

The system SHALL provide a `highContrastModeProvider` (StateNotifierProvider) that the SettingsScreen toggles and the AppTheme reads to determine which theme to apply.

#### Scenario: Provider returns current state
- **WHEN** `highContrastModeProvider` is read
- **THEN** it SHALL return `true` if high contrast is enabled, `false` otherwise
- **WHEN** the toggle is switched
- **THEN** the provider SHALL update immediately
- **THEN** all widgets rebuilding from the provider SHALL reflect the change
