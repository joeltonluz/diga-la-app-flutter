## Why

O app Diga Lá tem um motor AAC funcional (grade + TTS + barra de frase), mas o modo principal "Conversar" está limitado a apenas 12 cartões genéricos, enquanto 227+ cartões categorizados ficam presos no modo "Aprender". A barra de frase não permite reordenar ou remover cartões específicos, não há feedback visual durante a fala, e frases montadas não podem ser salvas. Essas limitações impedem que o app seja usado como ferramenta AAC no dia a dia por crianças autistas não-verbais.

Esta change resolve essas lacunas para tornar o app funcional como AAC de verdade, preparando também o terreno para monetização futura.

## What Changes

1. **Unificar acesso aos cartões das categorias no Conversar** — todos os 227+ cartões das categorias (Animais, Frutas, etc.) ficam disponíveis no modo Conversar, não apenas no Aprender
2. **Feedback visual durante o TTS** — o cartão sendo falado na sentença é destacado visualmente
3. **Reordenar e remover cartão específico da frase** — drag-and-drop para reordenar, tap para remover um cartão do meio
4. **Frases salvas (favoritas)** — salvar frases completas e reutilizá-las com um toque
5. **Modo alto contraste** — tema de alto contraste implementado de verdade (hoje é um stub)

## Capabilities

### New Capabilities
- `category-card-bridge`: Unificar o acesso aos cartões das categorias no ConverseScreen, permitindo navegar por categorias e adicionar cartões à sentença
- `sentence-editing`: Reordenar cartões na barra de frase via drag-and-drop e remover cartão específico com tap
- `tts-visual-feedback`: Destacar visualmente o cartão atual sendo falado durante a reprodução da sentença
- `saved-phrases`: Salvar, listar e reutilizar frases completas construídas no ConverseScreen
- `high-contrast-mode`: Tema de alto contraste funcional, ativável nas configurações

### Modified Capabilities
<!-- Nenhuma capability existente tem requisitos alterados — apenas novas capabilities são adicionadas -->

## Impact

- **Arquivos afetados:**
  - `lib/screens/converse_screen.dart` — reformulação para incluir categorias, edição de sentença, feedback visual
  - `lib/widgets/sentence_bar.dart` — suporte a reordenação, remoção específica, highlight TTS
  - `lib/widgets/card_tile.dart` — possíveis ajustes de interação (long-press para ouvir)
  - `lib/screens/home_screen.dart` — acesso a frases salvas
  - `lib/screens/settings_screen.dart` — toggle de alto contraste
  - `lib/theme/app_theme.dart` — implementar `highContrast()`
  - `lib/services/language_service.dart` — estender para suportar highlight de card ativo
  - `lib/providers/` ou `lib/presentation/providers/` — novo provider para frases salvas
- **Novas dependências:** Nenhuma (solução local com SQLite/Isar ou SharedPreferences para frases salvas)
- **Nenhuma alteração na navegação ou estrutura de rotas existente**
