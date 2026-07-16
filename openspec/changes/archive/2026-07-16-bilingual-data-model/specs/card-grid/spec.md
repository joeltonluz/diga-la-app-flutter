## MODIFIED Requirements

### Requirement: Card data model
**FROM:**
The system SHALL define a `Card` model with an `id` (String), `label` (String — the text to speak), and `emoji` (String — the visual representation).

**TO:**
The system SHALL define a `Card` model with an `id` (String), `labelPt` (String — the text to speak in Brazilian Portuguese), `labelEn` (String — the text to speak in English), and `emoji` (String — the visual representation). The model SHALL also expose a getter `label` that returns `labelPt` for backwards compatibility.

#### Scenario: Card model has bilingual fields
- **WHEN** the source code is inspected
- **THEN** a `Card` class SHALL exist with fields `id`, `labelPt`, `labelEn`, and `emoji`
- **THEN** the `Card` class SHALL have a getter `label` that returns `labelPt`

#### Scenario: Backwards-compatible getter works
- **WHEN** existing code reads `card.label`
- **THEN** it SHALL receive the Portuguese label (`labelPt`)

### Requirement: Fixed list of sample cards
**FROM:**
The system SHALL provide a hardcoded list of at least 10 initial cards with labels covering basic communication needs. The cards SHALL include at least: água, comida, banheiro, dormir, brincar, casa, sim, não, quero, acabou.

**TO:**
The system SHALL provide a hardcoded list of at least 10 initial cards with labels in both Portuguese and English covering basic communication needs. Each card SHALL have a `labelPt` and `labelEn`. The cards SHALL include at least: água/water, comida/food, banheiro/bathroom, dormir/sleep, brincar/play, casa/home, sim/yes, não/no, quero/want, acabou/finished.

#### Scenario: Sample cards list is bilingual
- **WHEN** the app is running and the Conversar screen is displayed
- **THEN** the screen SHALL show cards whose `labelPt` values are "água", "comida", "banheiro", "dormir", "brincar", "casa", "sim", "não", "quero", and "acabou"
- **THEN** each card SHALL also have a `labelEn` populated with the corresponding English translation
