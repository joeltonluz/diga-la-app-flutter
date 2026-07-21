## ADDED Requirements

### Requirement: Save current sentence as a phrase

The ConverseScreen SHALL provide a "Save" button that persists the current sentence as a saved phrase. The user SHALL be able to optionally name the phrase before saving.

#### Scenario: Save button saves phrase
- **WHEN** the sentence bar contains one or more cards
- **WHEN** the user taps the Save button
- **THEN** a dialog SHALL appear asking for an optional name for the phrase
- **THEN** the current sequence of card IDs, the name, and the current timestamp SHALL be persisted
- **THEN** a confirmation snackbar SHALL be displayed

#### Scenario: Save button disabled when sentence is empty
- **WHEN** the sentence bar is empty
- **THEN** the Save button SHALL be disabled (reduced opacity, non-interactive)

### Requirement: Saved phrases screen

The system SHALL provide a screen listing all saved phrases, accessible from the HomeScreen and/or ConverseScreen. Each saved phrase SHALL show its name (or first few card emojis if unnamed), and the user SHALL be able to tap to load or long-press to delete.

#### Scenario: Saved phrases screen shows list
- **WHEN** the user opens the saved phrases screen
- **THEN** each saved phrase SHALL be displayed with its name (or auto-generated label from first 3 card emojis) and creation date
- **THEN** if no phrases exist, an empty state message SHALL be shown ("Nenhuma frase salva" / "No saved phrases")

#### Scenario: Tap loads phrase into sentence bar
- **WHEN** the user taps a saved phrase
- **THEN** the app SHALL navigate to the ConverseScreen
- **THEN** the sentence bar SHALL be populated with the cards from that phrase
- **THEN** the user SHALL be able to speak, edit, or re-save the phrase

#### Scenario: Long-press to delete
- **WHEN** the user long-presses a saved phrase
- **THEN** a confirmation dialog SHALL appear
- **WHEN** the user confirms deletion
- **THEN** the phrase SHALL be removed from the saved list
- **THEN** the list SHALL update immediately

### Requirement: Persistence of saved phrases

Saved phrases SHALL be persisted on the device and restored when the app restarts.

#### Scenario: Phrases survive restart
- **WHEN** the user saves one or more phrases
- **WHEN** the app is closed and reopened
- **THEN** the saved phrases SHALL be available from the saved phrases screen

### Requirement: SavedPhrase model and provider

The system SHALL define a `SavedPhrase` model with `id` (String), `name` (String?), `cardIds` (List\<String\>), and `createdAt` (DateTime). A `SavedPhrasesNotifier` (StateNotifier) SHALL manage the list with `load()`, `save()`, `delete()`, and `loadInto()` methods.

#### Scenario: SavedPhrase has required fields
- **WHEN** a saved phrase is created
- **THEN** it SHALL have a unique `id` (UUID), an optional `name`, a non-empty list of `cardIds`, and a `createdAt` timestamp
