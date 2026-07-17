## Why

O visual-system já estabeleceu tokens de design (cores, tipografia, botões) no tema, mas as telas principais — criadas antes ou durante o visual-system — ainda usam cores incorretas: texto do título usa `colorScheme.primary` em vez de `onSurface`, subtítulo tem emoji indevido, botão secundário é `ElevatedButton` em vez de `OutlinedButton`, e há valores `Colors.transparent`, `Colors.grey` e hex hardcoded espalhados. Isso quebra a identidade visual e o princípio de baixa carga sensorial. Esta change corrige o consumo do tema em todas as telas.

## What Changes

- **HomeScreen**: título "Diga Lá" usa `textPrimary` (onSurface), não `primary`; subtítulo sem emoji "🧩" e cor secundária; botão "Aprender" trocado para `OutlinedButton` (secundário).
- **ConverseScreen**: botões de ação secundários (voltar/lixeira) usando tokens do tema em vez de `surfaceContainerHighest`/`Colors.transparent`/`onSurface` soltos; ícone de play usa tokens do tema.
- **LearnScreen**: cartões de categoria sem elevação/elementos visuais hardcoded (elevation: 1, borderRadius: 16, etc.) — migrados para `CardTheme` do tema ou tokens.
- **SettingsScreen**: cards de seleção (idioma, voz, velocidade) consumindo `colorScheme.primary`/`outline`/`surface` do tema de forma coerente.
- **card_tile.dart** e **sentence_bar.dart**: já migrados no visual-system — apenas conferir que não regrediram.
- **Testes**: ajustar `app_test.dart` e criar testes específicos para cada correção.

## Capabilities

### New Capabilities
- Nenhuma — é uma change de correção.

### Modified Capabilities
- `visual-system`: as telas principais agora consomem corretamente os tokens do tema que o visual-system definiu.

## Impact

- `lib/screens/home_screen.dart`: corrigir cores do título/subtítulo, emoji, tipo do botão "Aprender".
- `lib/screens/converse_screen.dart`: corrigir cores dos botões secundários e ícone de play.
- `lib/screens/learn_screen.dart`: migrar cartões de categoria para tokens do tema.
- `lib/screens/settings_screen.dart`: corrigir cards de seleção para usar tokens consistentes.
- `test/screens/home_screen_test.dart`: novos testes (se criar), ou `test/app_test.dart`: ajustar.
- Nenhuma dependência nova. Nenhuma mudança em widgets compartilhados, modelo de dados, ou providers.
