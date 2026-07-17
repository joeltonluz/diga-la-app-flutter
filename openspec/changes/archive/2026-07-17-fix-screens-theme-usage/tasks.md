## 1. Testes (TDD -- escrever primeiro, devem falhar)

- [x] 1.1 Ajustar `test/app_test.dart`: teste de splash atualizado, adicionar teste que HomeScreen titulo NAO usa cor primary e subtitulo NAO tem emoji
- [x] 1.2 Criar `test/screens/home_screen_test.dart` com teste que botao "Aprender" e OutlinedButton e "Conversar" e ElevatedButton
- [x] 1.3 Rodar testes e confirmar que FALHAM (cores e botoes ainda incorretos)

## 2. Corrigir HomeScreen

- [x] 2.1 Título "Diga La": substituir `colorScheme.primary` por `DesignTokens.colors.textPrimary` (ou onSurface)
- [x] 2.2 Subtitulo: remover emoji "🧩", substituir cor por `DesignTokens.colors.textSecondary`
- [x] 2.3 Botao "Aprender": trocar de `ElevatedButton` para `OutlinedButton`

## 3. Corrigir LearnScreen

- [x] 3.1 Cartoes de categoria: substituir `color: theme.colorScheme.surface` por `color: DesignTokens.colors.surfaceCard`
- [x] 3.2 Substituir `borderRadius: BorderRadius.circular(16)` por `borderRadius: DesignTokens.radii.card`
- [x] 3.3 Substituir `elevation: 1` por `boxShadow: DesignTokens.shadows.card` no Container decoration
- [x] 3.4 Substituir `InkWell.borderRadius` fixo por `DesignTokens.radii.card`

## 4. Corrigir ConverseScreen

- [x] 4.1 `_SecondaryButton`: fundo ativo usar `DesignTokens.colors.borderSoft.withValues(alpha: 0.3)`; icone ativo usar `DesignTokens.colors.textPrimary`
- [x] 4.2 Botao de play: conferir que usa `primary` (brand) e sombra brand -- ja esta correto, apenas conferir

## 5. Corrigir SettingsScreen

- [x] 5.1 `_ModeCard`, `_VoiceCard`, `_RateCard`: substituir `BorderRadius.circular(20)` por `DesignTokens.radii.card`
- [x] 5.2 Substituir `color: theme.colorScheme.surface` por `DesignTokens.colors.surfaceCard` nos cards nao selecionados
- [x] 5.3 Substituir cor de borda nao selecionado `outline.withValues(alpha: 0.3)` por `DesignTokens.colors.borderSoft`

## 6. Validar

- [x] 6.1 Rodar `flutter test` completo -- todos os testes passam
- [x] 6.2 Rodar `flutter analyze` -- sem warnings ou erros
- [ ] 6.3 Rodar `flutter run` para conferencia visual contra mockups
