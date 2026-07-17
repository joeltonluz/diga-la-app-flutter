## 1. Testes (TDD — escrever primeiro, devem falhar)

- [x] 1.1 Atualizar `test/screens/settings_screen_test.dart`: testar que o AppBar tem título "Configurações" e botão voltar
- [x] 1.2 Adicionar teste que os dois cartões de idioma (Português, English) estão visíveis com flag, título e descrição
- [x] 1.3 Adicionar teste que selecionar um cartão de idioma reflete no estado (rádio marcado / destaque visual)
- [x] 1.4 Adicionar teste que a seção Voz existe com botão "Ouvir" para cada voz
- [x] 1.5 Adicionar teste que a seção Velocidade existe com controle de velocidade presente
- [x] 1.6 Rodar testes e confirmar que falham (1/5 falha: AppBar back button não existe)

## 2. Refatorar AppBar e estrutura geral

- [x] 2.1 Adicionar `leading: IconButton` com `Icons.arrow_back_rounded` + `Navigator.pop(context)` no AppBar
- [x] 2.2 Substituir referências a `theme.colorScheme.primary` por `DesignTokens.colors.brand`
- [x] 2.3 Substituir referências a `theme.colorScheme.onSurface.withValues(alpha: ...)` por `DesignTokens.colors.textSecondary` ou similar
- [x] 2.4 Substituir referências a `theme.textTheme.*` por `DesignTokens.textStyles.*`
- [x] 2.5 Substituir referências a `theme.colorScheme.outline` por `DesignTokens.colors.borderSoft`

## 3. Refatorar cartões de idioma (_ModeCard)

- [x] 3.1 Estado selecionado: fundo brand claro + borda `DesignTokens.colors.brand` (2px)
- [x] 3.2 Estado não selecionado: fundo `DesignTokens.colors.surfaceCard` + borda `DesignTokens.colors.borderSoft` (1.5px)
- [x] 3.3 Rádio à direita: círculo preenchido brand quando selecionado, outline borderSoft quando não
- [x] 3.4 Flag: `Text` com `fontSize: 34` (manter existente)
- [x] 3.5 Título: `DesignTokens.textStyles.bodyLarge`
- [x] 3.6 Descrição: `DesignTokens.textStyles.bodyMedium` em `DesignTokens.colors.textSecondary`

## 4. Refatorar seção Voz (_VoiceSection / _VoiceCard)

- [x] 4.1 Trocar de cards individuais para linhas com divisor `borderSoft`
- [x] 4.2 Rádio à esquerda: círculo preenchido brand quando selecionado, outline borderSoft quando não
- [x] 4.3 Nome da voz: `DesignTokens.textStyles.bodyLarge`
- [x] 4.4 Botão "Ouvir": `IconButton` com `Icons.play_circle_outline_rounded` em brand
- [x] 4.5 Rótulo da seção "Voz" em `DesignTokens.colors.brand` com `DesignTokens.textStyles.bodySmall`
- [x] 4.6 Remover descrição "Escolha a voz que o app usa para falar." (ou manter se estiver no mockup)

## 5. Refatorar seção Velocidade (_RateSection / _RateCard)

- [x] 5.1 Trocar de cards individuais para linhas com divisor `borderSoft`
- [x] 5.2 Layout: rádio à esquerda + nome + descrição + botão "Ouvir" à direita
- [x] 5.3 Rádio: círculo preenchido brand quando selecionado, outline borderSoft quando não
- [x] 5.4 Nome: `DesignTokens.textStyles.bodyLarge`
- [x] 5.5 Descrição: `DesignTokens.textStyles.bodyMedium` em `DesignTokens.colors.textSecondary`
- [x] 5.6 Botão "Ouvir": `IconButton` com `Icons.play_circle_outline_rounded` em brand
- [x] 5.7 Rótulo da seção "Velocidade" em `DesignTokens.colors.brand` com `DesignTokens.textStyles.bodySmall`

## 6. Validar

- [x] 6.1 Rodar `flutter test` completo — 76/76 passam
- [x] 6.2 Rodar `flutter analyze` — sem warnings ou erros
- [x] 6.3 Rodar `flutter run` para conferência visual contra mockup
