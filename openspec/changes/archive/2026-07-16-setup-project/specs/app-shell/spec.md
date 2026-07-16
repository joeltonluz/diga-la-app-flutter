## ADDED Requirements

### Requirement: App entry point clean of boilerplate
The app SHALL start from a `main.dart` that contains no counter example code, no FloatingActionButton, no tutorial comments, and no "You have pushed the button" text. The entry point SHALL only invoke `runApp` with the root MaterialApp widget.

#### Scenario: App launches without counter
- **WHEN** the app is launched
- **THEN** the counter text and FloatingActionButton from the Flutter template SHALL NOT appear
- **THEN** the app SHALL display the "Diga Lá" branding and home screen

### Requirement: Organized folder structure
The `lib/` directory SHALL be organized into subdirectories by function: `screens/`, `widgets/`, `theme/`, `services/`, and `providers/`. Each new source file SHALL be placed in the appropriate subdirectory.

#### Scenario: Folder structure exists
- **WHEN** the project is inspected
- **THEN** the `lib/` directory SHALL contain subdirectories named `screens/`, `widgets/`, `theme/`, `services/`, and `providers/`

### Requirement: Inclusive theme with soft colors
The app SHALL use a color palette with low saturation (below 30%) and soft tones. The primary color SHALL be a muted blue-gray. The background SHALL be a warm cream. Accent colors SHALL be soft. The theme SHALL use large touch targets (minimum 56dp height for interactive elements) and minimum font sizes of 18dp for body text and 24dp for titles.

#### Scenario: Theme is applied
- **WHEN** the app renders any screen
- **THEN** the background color SHALL be a warm cream tone
- **THEN** interactive buttons SHALL have a minimum height of 56dp
- **THEN** body text SHALL be at minimum 18dp

### Requirement: High-contrast mode structure
The theme system SHALL be structured to support a future high-contrast mode. The `AppTheme` class SHALL expose a factory or static method for the regular theme and SHALL have the structure to add a high-contrast variant without refactoring.

#### Scenario: Theme class is structured for extensibility
- **WHEN** the theme source file is inspected
- **THEN** the theme class SHALL have at least one constructor or static method for the regular theme
- **THEN** the theme class SHALL be designed so a high-contrast variant can be added by creating a new constructor or static method

### Requirement: Navigation between home and modes
The app SHALL have three screens: Home (tela Início), Converse (Modo Conversar placeholder), and Learn (Modo Aprender placeholder). The home screen SHALL display the "Diga Lá" logo/title and two buttons labeled "Conversar" and "Aprender". Each button SHALL navigate to its respective screen. Each mode screen SHALL display its title and a back button to return home.

#### Scenario: Navigate from home to Converse
- **WHEN** the user taps "Conversar" on the home screen
- **THEN** the app SHALL navigate to a screen titled "Modo Conversar" or similar

#### Scenario: Navigate from home to Learn
- **WHEN** the user taps "Aprender" on the home screen
- **THEN** the app SHALL navigate to a screen titled "Modo Aprender" or similar

#### Scenario: Return from a mode screen
- **WHEN** the user is on a mode screen and taps the back button
- **THEN** the app SHALL return to the home screen

### Requirement: App branding with logo and label
The app SHALL display "Diga Lá" as the app label on Android. The logo for "Diga Lá" SHALL be placed in `assets/logo.png`. The `pubspec.yaml` SHALL declare the `assets/` directory. The app icon SHALL be generated from `assets/logo.png` using `flutter_launcher_icons`.

#### Scenario: Logo asset is registered
- **WHEN** the pubspec.yaml is inspected
- **THEN** the `flutter > assets` section SHALL include `assets/logo.png`

#### Scenario: App label is "Diga Lá"
- **WHEN** the AndroidManifest.xml is inspected
- **THEN** the `android:label` attribute SHALL be `"Diga Lá"`

### Requirement: Boilerplate tests removed
The default Flutter counter widget test SHALL be removed and replaced with a smoke test that validates the home screen renders without errors.

#### Scenario: Boilerplate test is replaced
- **WHEN** tests are run with `flutter test`
- **THEN** the counter test SHALL NOT be present
- **THEN** a valid test SHALL pass without errors
