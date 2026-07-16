## Why

O modelo de cartão já suporta PT e EN (bilingual-data-model), mas o app ainda só fala PT-BR fixo. Para realizar o comportamento bilíngue global definido no project.md — onde o cuidador escolhe se o app fala PT, EN ou PT+EN — precisamos de uma configuração central de idioma, persistida no aparelho, e de um serviço que todos os modos consultam na hora de falar. Esta change é o cérebro do bilinguismo.

## What Changes

- **`LanguageService`**: serviço central que guarda a preferência de idioma e expõe um método `speak(Card)` que decide o quê e como falar com base na configuração.
- **Três opções de idioma**: Só PT, Só EN, PT+EN (sequência).
- **Persistência da preferência**: primeira persistência real do projeto.
- **Tela de Configurações**: acessível por ícone de engrenagem na tela inicial, com seleção de idioma em formato inclusivo (toques grandes, opções claras).
- **Modo Conversar modificado**: em vez de `tts.speak(card.label)`, chama o `LanguageService` que decide o texto e locale.
- **Nova dependência**: pacote de persistência escolhido (shared_preferences ou hive).

## Capabilities

### New Capabilities

- `language-settings`: Configuração central de idioma com três opções (PT, EN, PT+EN), persistida no aparelho, com tela de configuração e serviço consumido pelos modos.

### Modified Capabilities

- `card-grid`: O Modo Conversar (ConverseScreen) passa a consultar o LanguageService em vez de falar `card.label` diretamente. A especificação do requisito "Tap card speaks label" é atualizada para refletir o comportamento dependente da configuração.

## Impact

- `lib/services/language_service.dart` — novo serviço central
- `lib/providers/language_provider.dart` — novo provider Riverpod
- `lib/screens/settings_screen.dart` — nova tela de configurações
- `lib/screens/home_screen.dart` — adiciona ícone de engrenagem
- `lib/screens/converse_screen.dart` — troca `tts.speak(card.label)` por `languageService.speak(card)`
- `lib/services/tts_service.dart` — pode precisar de ajustes para suportar troca de locale
- `pubspec.yaml` — adiciona dependência de persistência
