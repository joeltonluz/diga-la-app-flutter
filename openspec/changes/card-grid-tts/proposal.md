## Why

O Modo Conversar é o coração do app Diga Lá — a funcionalidade primária de CAA que permite à criança se expressar tocando cartões que o aparelho fala em voz alta. O setup-project deixou a tela "Conversar" como placeholder vazio. Esta change realiza a promessa central do app: uma grade de cartões que falam ao toque.

## What Changes

- **Modelo de dados `Card`** com id, rótulo de texto e representação visual (emoji/ícone).
- **Lista fixa de 10 cartões** iniciais de comunicação essencial (água, comida, banheiro, dormir, brincar, casa, sim, não, quero, acabou).
- **Grade responsiva (`GridView`)** substituindo o placeholder da tela Conversar.
- **CardTile widget**: alvo de toque grande com emoji + texto + feedback visual discreto.
- **Integração com TTS**: ao tocar um cartão, o texto é falado via `TtsService`.
- **Remoção do botão temporário de TTS** da tela inicial (já não é mais necessário).

## Capabilities

### New Capabilities

- `card-grid`: Grade de cartões de comunicação com modelo de dados, lista fixa, renderização em grid e reprodução TTS ao toque.

### Modified Capabilities

Nenhuma — primeira mudança após o setup-project.

## Impact

- `lib/models/card.dart` — novo modelo.
- `lib/data/sample_cards.dart` — lista fixa de cartões iniciais.
- `lib/widgets/card_tile.dart` — novo widget de cartão.
- `lib/screens/converse_screen.dart` — substitui placeholder pela grade.
- `lib/widgets/temp_tts_button.dart` — removido (não é mais necessário).
- `lib/screens/home_screen.dart` — remove referência ao `TempTtsButton`.
