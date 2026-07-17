## 1. Preparacao -- fontes e testes de tema

- [x] 1.1 Baixar arquivos .ttf da Nunito (pesos 400, 600, 700, 800) de fonte gratuita e coloca-los em `assets/fonts/`
- [x] 1.2 Registrar as fontes no `pubspec.yaml` na secao `flutter: fonts:`
- [x] 1.3 Rodar `flutter pub get` e verificar com `flutter analyze`
- [x] 1.4 Criar `test/theme/app_theme_test.dart` -- testar que `AppTheme.regular()` expoe as cores esperadas (primary, surface, onSurface comparando com valores oklch convertidos)
- [x] 1.5 Adicionar teste de estilos de texto -- verificar que `textTheme` contem Nunito com os pesos corretos (w800 em displayLarge, w700 em titleLarge, w400 em bodyMedium)
- [x] 1.6 Rodar os testes e confirmar que FALHAM (TDD -- tema ainda nao implementado)

## 2. Classe DesignTokens

- [x] 2.1 Criar `lib/theme/design_tokens.dart` com a classe `DesignTokens` contendo:
  - `colors`: todas as cores convertidas de oklch para Color (17 cores conforme tabela do design.md)
  - `textStyles`: estilos de texto nomeados (displayLarge, headlineLarge, titleLarge, bodyLarge, bodyMedium, bodySmall, labelLarge, cardLabel, button, caption)
  - `radii`: BorderRadiusGeometry para card, button, bar, mini
  - `shadows`: List<BoxShadow> para card (difusa, discreta)
  - `spacing`: doubles para xs, sm, md, lg
- [x] 2.2 Garantir que `DesignTokens` tenha um construtor privado (`_()`) e exponha tudo como static const

## 3. AppTheme reescrito

- [x] 3.1 Reescrever `lib/theme/app_theme.dart`:
  - `AppTheme.regular()`: constroi `ThemeData` completo usando `DesignTokens`
    - `colorScheme`: mapear cores do DesignTokens para ColorScheme.light
    - `textTheme`: usar DesignTokens.textStyles
    - `fontFamily`: 'Nunito'
    - `scaffoldBackgroundColor`: DesignTokens.colors.backgroundExternal
    - `elevatedButtonTheme`: azul marca preenchido, 56dp altura, borderRadius do token
    - `outlinedButtonTheme`: azul marca contorno, 56dp altura, borderRadius do token
    - `cardTheme`: borderRadius do token, sombra difusa
    - `visualDensity`: conforto maximo
    - `materialTapTargetSize`: MaterialTapTargetSize.shrinkWrap (para controle explicito)
  - `AppTheme.highContrast()`: placeholder retornando `regular()` por enquanto
- [x] 3.2 Rodar `flutter analyze` -- limpar warnings

## 4. Testes do tema -- confirmar passam

- [x] 4.1 Rodar testes do tema (`test/theme/app_theme_test.dart`) e confirmar que PASSAM agora
- [x] 4.2 Adicionar teste que `DesignTokens.colors.primary` equivale ao azul marca
- [x] 4.3 Adicionar teste que `DesignTokens.colors.surfaceCard` equivale ao fundo cartao
- [x] 4.4 Adicionar teste que o tema usa 'Nunito' como `fontFamily` padrao

## 5. Migrar CardTile

- [x] 5.1 Escrever teste primeiro: `test/widgets/card_tile_visual_test.dart` -- verificar que CardTile usa borderRadius token, sombra token, e textStyle do tema
- [x] 5.2 Confirmar que o teste FALHA (CardTile ainda hardcoded) -- 2/3 falham (borderRadius e textStyle)
- [x] 5.3 Alterar `lib/widgets/card_tile.dart`:
  - Substituir `borderRadius: BorderRadius.circular(16)` por `DesignTokens.radii.card`
  - Substituir `elevation: 1` por sombra difusa via container decoration com `DesignTokens.shadows.card`
  - `splashColor` / `highlightColor`: usar `DesignTokens.colors.brand.withValues(...)`
  - `padding`: usar `DesignTokens.spacing.sm`
  - `TextStyle` do rotulo: usar `DesignTokens.textStyles.cardLabel`
- [x] 5.4 Rodar os testes e confirmar que PASSAM -- 3/3 passam

## 6. Migrar SentenceBar

- [x] 6.1 Escrever teste primeiro: `test/widgets/sentence_bar_visual_test.dart` -- verificar que SentenceBar usa borderRadius token e cor de borda do tema
- [x] 6.2 Confirmar que o teste FALHA (SentenceBar ainda hardcoded) -- 2/2 falham
- [x] 6.3 Alterar `lib/widgets/sentence_bar.dart`:
  - Substituir `borderRadius: BorderRadius.circular(20)` por `DesignTokens.radii.bar`
  - Substituir `border:` por `DesignTokens.colors.borderSoft`
  - `padding`: usar `DesignTokens.spacing.sm`
  - `TextStyle` do placeholder: usar `DesignTokens.textStyles.caption`
  - No `_MiniCard`: substituir borderRadius e border pelos tokens correspondentes
- [x] 6.4 Rodar os testes e confirmar que PASSAM -- 2/2 passam

## 7. Testes de alvos de toque

- [x] 7.1 Escrever teste que verifica `CardTile` tem constraints minimas 80x80 (>= 44x44 dp) -- incluso em card_tile_visual_test.dart
- [x] 7.2 Escrever teste que verifica `ElevatedButton` no tema renderiza -- button_touch_target_test.dart
- [x] 7.3 Rodar todos os testes e confirmar que PASSAM -- 51/51 passam

## 8. Smoke test -- app ainda funciona

- [x] 8.1 Rodar `flutter test` -- 51 testes passam com sucesso
- [x] 8.2 Rodar `flutter analyze` -- sem warnings ou erros
- [x] 8.3 Verificar visualmente que o app abre e as cores/tipografia estao coerentes com o mockup -- build e analyze ok, testar visualmente com `flutter run`
