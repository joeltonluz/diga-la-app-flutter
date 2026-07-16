## Context

O app Diga Lá tem 4 changes implementadas. Apenas 1 teste existe (`app_test.dart`). O código usa `flutter_tts` (chama áudio real, não testável em CI) e `shared_preferences` (acessa disco real). A próxima change vai refatorar `LanguageService` para remover o modo `ptEn` — isso muda a lógica de `speak()` e `setMode()`. Precisamos de testes que documentem e tranquem o comportamento atual.

## Goals / Non-Goals

**Goals:**
- Testes unitários do `LanguageService` (modos, persistência, speak)
- Testes unitários do modelo `Card` bilíngue
- Testes unitários da lógica da barra de frase (add, remove, clear)
- Widget tests da `SentenceBar` (renderiza cartões, placeholder)
- Widget test da `SettingsScreen` (lista 3 opções de idioma)
- Mocks para `FlutterTts` e `SharedPreferences`

**Non-Goals:**
- Não testar saída de áudio real (impossível em teste de unidade/widget)
- Não testar `TtsService` isoladamente (é wrapper thin do flutter_tts)
- Não testar navegação completa (home → conversar → etc.)
- Não testar grid de cartões em detalhe (já coberto pelo teste de integração existente)
- Não adicionar testes de integração com áudio
- Não mudar código de produção

## Decisions

### mocktail vs. mockito
**Decisão:** `mocktail` — sem code generation, sem `build_runner`, zero configuração. Para os poucos mocks necessários (FlutterTts, SharedPreferences), mocktail cobre bem.

### Como mockar SharedPreferences
**Decisão:** Usar `SharedPreferences.setMockInitialValues({})` antes de cada teste que depende de persistência. É o mecanismo oficial de teste do pacote — não precisa de mock manual. Isso define valores iniciais que o `SharedPreferences.getInstance()` retorna em ambiente de teste.

### Como mockar TtsService (e FlutterTts)
**Decisão:** `LanguageService` recebe `TtsService` por injeção. Criar `MockTtsService` com mocktail e passar ao construtor. O `speak()` real não será chamado. Isso isola a lógica de decisão de idioma do áudio.

### Estrutura de pastas de teste
**Decisão:** `test/` espelha `lib/`:
```
test/
  models/
    card_test.dart
  services/
    language_service_test.dart
  widgets/
    sentence_bar_test.dart
  screens/
    settings_screen_test.dart
  helpers/
    mocks.dart
```
Padrão Flutter convencional.

### O que testar no LanguageService
**Decisão:** Testar a árvore de decisão de `speak()` — dado um modo e um cartão, qual texto e locale seriam passados ao TTS. Para isso, mockar `TtsService.setLanguage()` e `TtsService.speak()` e verificar os argumentos recebidos. Isso isola a lógica mais crítica para a refatoração futura.

### SentenceBar em widget test
**Decisão:** Testar com `pumpWidget` que a `SentenceBar`:
- Mostra placeholder quando vazia
- Mostra mini-cards quando recebe cartões
- Rola horizontalmente (verificar se o scroll existe)

## Risks / Trade-offs

- **SharedPreferences.setMockInitialValues é global:** Cada teste que modifica o mock afeta outros testes no mesmo isolate. Mitigação: usar `setUp`/`tearDown` para resetar o mock antes de cada teste.
- **Widget tests com Riverpod:** `SettingsScreen` depende de `languageServiceProvider` que depende de `SharedPreferences`. Mitigação: usar `ProviderScope` com overrides nos testes, fornecendo `LanguageService` mockado.
- **Testes frágeis de UI:** Mudanças visuais (padding, cor) quebram widget tests. Mitigação: testar presença/ausência de widgets, não valores exatos de estilo.

## Open Questions

- Nenhuma por enquanto.
