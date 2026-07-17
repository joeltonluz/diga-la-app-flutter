## MODIFIED Requirements

### Requirement: Voice preview

Each voice option SHALL be displayed as a compact row with a radio indicator, the voice name, and a play preview button. The selected voice SHALL show a filled brand radio. The play button SHALL use secondary styling coherent with DesignTokens. Subtle dividers (DesignTokens.colors.borderSoft) SHALL separate voice rows.

#### Scenario: Voice row shows radio, name, and play button
- **WHEN** the caregiver opens the Settings screen
- **THEN** each voice option SHALL be a row with:
- **THEN** a radio circle on the left (filled brand when selected, empty outline when not)
- **THEN** the voice name in DesignTokens.textStyles.bodyLarge
- **THEN** an "Ouvir" play button on the right with secondary button styling
- **THEN** rows SHALL be separated by a divider using DesignTokens.colors.borderSoft

#### Scenario: Play button speaks preview
- **WHEN** the caregiver taps the play button next to a voice option
- **THEN** the system SHALL speak the preview phrase using that voice
