## Context

O tema possui `DesignTokens.colors` com cores nomeadas (textPrimary, textSecondary, brand, surfaceScreen, etc.) e o `AppTheme` já configura `colorScheme`, `elevatedButtonTheme` e `outlinedButtonTheme`. As telas, no entanto, usam `colorScheme.primary` para texto, ignoram os botões temáticos, e contêm valores visuais hardcoded.

## Goals / Non-Goals

**Goals:**
- HomeScreen: título com `textPrimary`, subtítulo sem emoji com `textSecondary`, botão "Aprender" como `OutlinedButton`.
- ConverseScreen: botões de ação secundários usando tokens consistentes.
- LearnScreen: cartões de categoria usando tokens do tema em vez de valores fixos.
- SettingsScreen: cards de seleção usando `brand` (primary) para selecionado, `borderSoft`/`outline` para não selecionado, sem `Colors.transparent` ou `Colors.grey` soltos.
- Todos os `BorderRadius.circular(X)` fixos migrados para `DesignTokens.radii`.
- Zero cores hardcoded soltas nos widgets de tela.
- Manter fluxos, navegação, estrutura de layout existentes.

**Non-Goals:**
- Redesenho de layout ou posicionamento de elementos.
- Novos widgets ou cartões (comer, ajuda, etc.).
- Mudanças em CardTile, SentenceBar ou DesignTokens (já estão corretos).
- Alteração de comportamento de navegação ou lógica de estado.

## Decisions

### 1. Mapa papel → token do tema

| Papel visual | Token correto | Onde estava usando errado |
|---|---|---|
| Título principal (Diga La) | `DesignTokens.colors.textPrimary` (onSurface) | HomeScreen: `colorScheme.primary` |
| Subtitulo/descricao | `DesignTokens.colors.textSecondary` | HomeScreen: `colorScheme.primary.withAlpha(0.7)` |
| Botao primario (preenchido) | `ElevatedButton` (ja configurado no tema) | HomeScreen "Conversar": OK |
| Botao secundario (contorno) | `OutlinedButton` (ja configurado no tema) | HomeScreen "Aprender": era `ElevatedButton` |
| Borda de cartao nao selecionado | `borderSoft` (ou `outline` com alpha) | SettingsScreen: `outline` direto |
| Fundo de cartao selecionado | `brand` com alpha ~0.08 | OK (ja usa `primary.withAlpha(0.08)`) |
| Circulo de selecao ativo | `brand` (primary) | OK |
| Texto descritivo secundario | `onSurface` com alpha ~0.55 (textSecondary) | OK na maioria |
| Cartao de categoria no Learn | `CardTheme` do tema (surfaceCard, borderRadius card, shadow card) | Atualmente: `surface`, `elevation: 1`, `borderRadius: 16` fixos |

### 2. Correcoes especificas por tela

**HomeScreen:**
- `Text("Diga La")` → `DesignTokens.textStyles.displayLarge.copyWith(color: DesignTokens.colors.textPrimary)`
- `Text("Comunicacao que aproxima")` (sem emoji) → `DesignTokens.textStyles.bodyMedium.copyWith(color: DesignTokens.colors.textSecondary)`
- Botao "Aprender": `ElevatedButton` → `OutlinedButton`

**ConverseScreen:**
- `_SecondaryButton`: cor de fundo ativo usar `DesignTokens.colors.borderSoft.withAlpha(0.3)` em vez de `surfaceContainerHighest`; inativo usar transparente. Cor do icone ativo usar `textPrimary`, inativo usar `textSecondary` com alpha baixo.
- Botao de play (speak): cor do circulo usar `brand`; icone usar `onPrimary` (ja OK). Sombra usar `brand` com alpha (ja OK).

**LearnScreen:**
- `Material(color:, borderRadius:, elevation:)` fixo → substituir por token:
  - `color`: `DesignTokens.colors.surfaceCard`
  - `borderRadius`: `DesignTokens.radii.card`
  - `elevation`: removida (sombra via `CardTheme` ou `DesignTokens.shadows.card`)
  - `InkWell.borderRadius`: `DesignTokens.radii.card`

**SettingsScreen:**
- `_ModeCard`, `_VoiceCard`, `_RateCard`: border radius fixo `20` → `DesignTokens.radii.card`
- Cor de borda nao selecionado: `outline.withAlpha(0.3)` → `DesignTokens.colors.borderSoft` (ou `outline` com alpha)
- Fundo nao selecionado: `surface` → `surfaceCard` (consistente)
- `Colors.transparent` no radio nao selecionado: OK (design)
- Textos descritivos: `onSurface.withAlpha(0.55)` → `textSecondary` (via token indireto)

### 3. Nao mexer em CardTile e SentenceBar

Ja foram migrados no visual-system e estao corretos.

### 4. Testes

Os testes existentes em `app_test.dart` e `splash_screen_test.dart` devem continuar passando. Adicionar verificacoes especificas:
- HomeScreen: titulo NAO usa `primary`, subtitulo NAO contem emoji, botao "Aprender" e `OutlinedButton`.
- Telas: conferir que `Colors.transparent` nao aparece em elementos estruturais (apenas OK em radio nao selecionado).

## Risks / Trade-offs

- **[Regressao visual]** Alterar cores pode fazer botoes ou textos parecerem diferentes do esperado. **Mitigacao:** conferencia visual apos implementacao com `flutter run`, comparando com mockups.
- **[Testes quebrados]** Testes existentes que conferem texto exato ("Comunicacao que aproxima. 🧩") vao falhar com a remocao do emoji. **Mitigacao:** ajustar `app_test.dart` e `splash_screen_test.dart` para o novo texto sem emoji.
