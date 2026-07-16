## Purpose

Interactive vocabulary book organized into fixed categories, where the child navigates themes, taps items, and hears the word spoken by the central LanguageService.

## Requirements

### Requirement: Category model

The system SHALL define a `Category` model with an `id`, a `name` (String), an `icon` (emoji String), and a list of vocabulary items (`List<Card>`).

#### Scenario: Category has id, name, icon, and items
- **WHEN** a category is created
- **THEN** it SHALL have a unique `id`, a display `name`, an `icon` emoji, and a non-empty list of `Card` items

### Requirement: Fixed categories

The system SHALL ship with exactly five fixed categories, each containing five bilingual (PT+EN) cards. The categories SHALL be:
- Animais (🐾): cachorro/dog, gato/cat, pássaro/bird, peixe/fish, cavalo/horse
- Frutas (🍎): maçã/apple, banana/banana, laranja/orange, uva/grape, morango/strawberry
- Transportes (🚗): carro/car, ônibus/bus, avião/airplane, bicicleta/bicycle, barco/boat
- Partes do corpo (🖐️): cabeça/head, mão/hand, pé/foot, olho/eye, boca/mouth
- Cores (🎨): vermelho/red, azul/blue, amarelo/yellow, verde/green

#### Scenario: All five categories exist and are accessible
- **WHEN** the app loads the learn mode
- **THEN** all five categories SHALL be displayed with their icon and name

#### Scenario: Each category has exactly five items
- **WHEN** a category is opened
- **THEN** it SHALL contain exactly five vocabulary items, each with a `labelPt`, `labelEn`, and `emoji`

### Requirement: Category grid (home of learn mode)

The LearnScreen SHALL display a scrollable grid of categories. Each category tile SHALL show the category icon and name. Tapping a category SHALL navigate to its item grid.

#### Scenario: Categories are displayed in a grid
- **WHEN** the user navigates to the learn mode
- **THEN** a grid of category tiles SHALL be displayed
- **THEN** each tile SHALL show the category's emoji icon and name

#### Scenario: Tapping a category opens item grid
- **WHEN** the user taps a category tile
- **THEN** the app SHALL navigate to a new screen showing the items of that category

### Requirement: Item grid

The item grid screen SHALL display all vocabulary items of the selected category using the existing `CardTile` widget. Tapping an item SHALL call `LanguageService.speak(card)`.

#### Scenario: Items use CardTile widget
- **WHEN** the item grid is displayed
- **THEN** each item SHALL be rendered using the `CardTile` widget with its emoji and label

#### Scenario: Tap speaks via LanguageService
- **WHEN** the user taps an item in the item grid
- **THEN** the system SHALL call `LanguageService.speak(card)` with the tapped card

### Requirement: Back navigation

The item grid screen SHALL provide a clear way to return to the category grid, such as a back button in the AppBar.

#### Scenario: Back button returns to categories
- **WHEN** the user is on the item grid screen
- **THEN** the AppBar SHALL display a back button
- **WHEN** the user taps the back button
- **THEN** the app SHALL return to the category grid

### Requirement: Learn mode replaces placeholder

The existing placeholder in `LearnScreen` SHALL be replaced by the category grid implementation.

#### Scenario: Learn screen shows categories
- **WHEN** the user navigates to `/learn`
- **THEN** the screen SHALL display the category grid (not the placeholder text)
