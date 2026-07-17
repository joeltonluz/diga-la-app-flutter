## Why

O app "Diga Lá" foi configurado no setup-project com um tema genérico (cores aproximadas, sem fonte definida, sem tokens visuais). Com o acúmulo de funcionalidades (card-grid, sentence-bar, language-settings, learn-mode), o app começa a apresentar inconsistência visual — valores hardcoded de cor, raio, sombra se espalham pelos widgets. Isso dificulta manutenção, quebra a identidade visual e compromete o princípio de baixa carga sensorial. Esta change centraliza todo o sistema visual em tokens no tema do Flutter e migra os widgets compartilhados para consumi-los, garantindo coerência visual imediata em todas as telas.

## What Changes

- **Tokens de design centralizados** no tema (cores em oklch convertidas para Color, tipografia Nunito empacotada em assets, raios de canto, sombras, espaçamentos).
- **Fonte Nunito empacotada em assets** (offline, sem depender de download do google_fonts).
- **Tema Flutter reescrito** (`AppTheme`) com `ThemeData` completo: `colorScheme`, `textTheme`, `elevatedButtonTheme`, `outlinedButtonTheme`, `cardTheme`, sombras customizadas.
- **Widget `CardTile` migrado** para usar tokens do tema (sem cores/raios/sombras hardcoded).
- **Widget `SentenceBar` migrado** para usar tokens do tema.
- **Botões de ação** (primário azul preenchido, secundário com contorno) definidos no tema.
- **Alvos de toque** mantidos no mínimo 44x44 dp, com botões principais em 56dp de altura.
- **Testes** do tema expondo tokens esperados, widgets compartilhados consumindo tokens, e alvos de toque no tamanho mínimo.

### Não altera
- Fluxos, navegação, textos, layouts específicos de tela.
- Splash screen (change própria).
- Cartões novos do mockup Conversar (change própria).
- Nenhuma nova funcionalidade.

## Capabilities

### New Capabilities
- `visual-system`: Tema centralizado com tokens de design (cores, tipografia Nunito, raios, sombras, espaçamentos). Fonte única de verdade visual para todo o app.

### Modified Capabilities
- Nenhuma — é a primeira change focada em identidade visual. As specs existentes (card-grid, sentence-bar, language-settings etc.) não têm seus requisitos alterados; apenas a implementação visual é padronizada.

## Impact

- `lib/theme/app_theme.dart`: reescrito completamente com tokens de design.
- `lib/widgets/card_tile.dart`: removidos valores hardcoded de borderRadius, elevation, padding.
- `lib/widgets/sentence_bar.dart`: removidos valores hardcoded de borderRadius, border, padding.
- `pubspec.yaml`: adicionada fonte Nunito em assets; removido `google_fonts` se presente (não está).
- `assets/fonts/`: adicionados arquivos .ttf da Nunito (pesos 400, 600, 700, 800).
- `test/`: novos testes para tema, card_tile, sentence_bar, e alvos de toque.
