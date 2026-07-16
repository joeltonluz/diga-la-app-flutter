## 1. Infraestrutura de teste

- [x] 1.1 Adicionar `mocktail` ao `pubspec.yaml` em `dev_dependencies`
- [x] 1.2 Rodar `flutter pub get`
- [x] 1.3 Criar `test/helpers/mocks.dart` com `MockTtsService` estendendo `Mock` implementando `TtsService`

## 2. Testes do modelo Card

- [x] 2.1 Criar `test/models/card_test.dart`:
  - Card expõe `labelPt` e `labelEn` corretamente
  - `label` retorna `labelPt` como padrão

## 3. Testes do LanguageService

- [x] 3.1 Em `test/services/language_service_test.dart`:
  - Modo padrão é `pt` quando não há preferência salva
  - `setMode` altera `currentMode` e persiste via `SharedPreferences`
  - `speak()` no modo PT chama `setLanguage('pt-BR')` + `speak(labelPt)`
  - `speak()` no modo EN chama `setLanguage('en-US')` + `speak(labelEn)`
  - `speak()` no modo PT+EN chama ambos em sequência

## 4. Widget tests da SentenceBar

- [x] 4.1 Criar `test/widgets/sentence_bar_test.dart`:
  - Barra vazia exibe placeholder
  - Barra com cartões exibe emoji e label de cada cartão

## 5. Widget test da SettingsScreen

- [x] 5.1 Criar `test/screens/settings_screen_test.dart`:
  - Tela exibe as 3 opções de idioma: "Português", "English", "Português + English"
  - Usar `ProviderScope` com overrides para fornecer `LanguageService` mockado

## 6. Verificação

- [x] 6.1 Rodar `flutter test` e confirmar que todos os testes passam
- [x] 6.2 Verificar cobertura: `flutter test --coverage` e inspecionar `lcov.info`
