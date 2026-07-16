## Why

O app tem 4 changes implementadas (card-grid-tts, bilingual-data-model, language-settings, sentence-bar) e apenas 1 teste widget básico (`app_test.dart`). A próxima change vai refatorar o LanguageService para suportar apenas PT ou EN (removendo ptEn). Sem testes, qualquer refatoração é um voo cego. Precisamos de uma rede de segurança que trave o comportamento atual antes de mexer.

## What Changes

- Adicionar dependência `mockito` (ou `mocktail`) para mockar TTS e SharedPreferences
- Criar `test/services/language_service_test.dart` — testes unitários do LanguageService
- Criar `test/models/card_test.dart` — testes do modelo bilíngue
- Criar `test/widgets/sentence_bar_test.dart` — widget test da SentenceBar
- Criar `test/screens/settings_screen_test.dart` — widget test da SettingsScreen
- Nenhuma linha de produção é alterada

## Capabilities

### New Capabilities
- `retro-tests`: Cobertura de testes automatizados (unit + widget) para o comportamento já implementado do app

### Modified Capabilities
- *(Nenhuma — esta change só adiciona testes, não altera requisitos de produção)*

## Impact

- Adiciona `mocktail` ao `pubspec.yaml` (dev_dependencies)
- Cria `test/services/language_service_test.dart`
- Cria `test/models/card_test.dart`
- Cria `test/widgets/sentence_bar_test.dart`
- Cria `test/screens/settings_screen_test.dart`
- Cria `test/helpers/` com mocks compartilhados
- Nenhum arquivo de produção é tocado
