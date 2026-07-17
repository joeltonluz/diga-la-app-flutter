## MODIFIED Requirements

### Requirement: Rate levels

Each rate option SHALL be displayed as a compact row with a radio indicator, the level name and description, and a play preview button. The visual style SHALL match the voice rows (consistent layout, same tokens). Selected rate SHALL show a filled brand radio. All colors and typography SHALL use DesignTokens.

#### Scenario: Rate row shows radio, name, desc, and play button
- **WHEN** the caregiver opens the Settings screen
- **THEN** each rate option SHALL be a row with:
- **THEN** a radio circle on the left (filled brand when selected, empty outline when not)
- **THEN** the level name in DesignTokens.textStyles.bodyLarge
- **THEN** the level description in DesignTokens.textStyles.bodyMedium in textSecondary
- **THEN** an "Ouvir" play button on the right with secondary button styling
- **THEN** rows SHALL be separated by a divider using DesignTokens.colors.borderSoft
