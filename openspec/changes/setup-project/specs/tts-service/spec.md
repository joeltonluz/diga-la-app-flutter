## ADDED Requirements

### Requirement: TTS service initialization
The system SHALL provide a singleton service (via Riverpod provider) that initializes `flutter_tts` with default settings. The service SHALL be initialized once and be available throughout the app lifecycle.

#### Scenario: TTS service initializes
- **WHEN** the app starts and the TTS provider is first read
- **THEN** the `flutter_tts` instance SHALL be initialized
- **THEN** the TTS provider SHALL be available for injection into any widget

### Requirement: TTS speaks Portuguese (PT-BR)
The TTS service SHALL be configured to speak Brazilian Portuguese (`"pt-BR"`) as the default language. The service SHALL expose a method `speak(String text)` that queues the text for speech synthesis.

#### Scenario: Speak a PT-BR phrase
- **WHEN** `speak("Olá")` is called on the TTS service
- **THEN** the device SHALL play the audio for "Olá" in Brazilian Portuguese

### Requirement: TTS supports English
The TTS service SHALL support switching to English (`"en-US"`). The service SHALL expose a method `setLanguage(String lang)` that changes the TTS language.

#### Scenario: Switch language to English
- **WHEN** `setLanguage("en-US")` is called on the TTS service
- **THEN** subsequent `speak()` calls SHALL use English pronunciation

### Requirement: Temporary TTS test button
The home screen SHALL include a clearly labeled temporary button that calls `speak("Olá")` when tapped. This button SHALL be visually distinct (e.g., colored differently) and SHALL have a comment in code marking it as temporary for removal in a future change.

#### Scenario: Test button speaks "Olá"
- **WHEN** the user taps the temporary TTS test button on the home screen
- **THEN** the app SHALL speak "Olá" in Brazilian Portuguese

#### Scenario: Test button is marked temporary
- **WHEN** the source code of the test button is inspected
- **THEN** a code comment SHALL indicate this button is temporary and to be removed
