## Context

O app Diga Lá atualmente usa um tema genérico (`app_theme.dart`) com cores aproximadas (hardcoded como hex, sem valores oklch), sem fonte definida (usa a padrão do sistema), sem sombras customizadas, e com raios de canto definidos diretamente nos widgets. Os widgets compartilhados `CardTile` e `SentenceBar` contêm valores visuais hardcoded (borderRadius: 16, elevation: 1, cores fixas). Essa abordagem não escala — cada novo widget replica decisões visuais manualmente, gerando inconsistência.

Esta change substitui o tema genérico por um sistema visual baseado em tokens extraídos do design Figma/HTML do Claude Design. Todo o app (telas existentes e futuras) reflete a nova identidade visual automaticamente, pois consome `Theme.of(context)`.

## Goals / Non-Goals

**Goals:**
- Tokens de design (cores oklch, tipografia Nunito, raios, sombras, espaçamentos) centralizados em uma única classe de tema.
- Fonte Nunito empacotada em assets (offline) — pesos 400, 600, 700, 800.
- Valores oklch convertidos para Color do Flutter com conferência visual contra o mockup.
- `CardTile` e `SentenceBar` migrados para consumir tokens do tema (zero valores hardcoded).
- Botões primário (azul preenchido) e secundário (contorno) definidos no tema.
- Alvos de toque ≥ 44x44 dp, botões principais com altura mínima de 56 dp.
- Testes verificáveis: tema expõe tokens esperados, widgets usam tokens, alvos de toque mínimos.

**Non-Goals:**
- Layout específico de qualquer tela (Início, Conversar, Aprender, Configurações).
- Splash screen.
- Cartões novos do mockup Conversar (change própria).
- Modo alto contraste funcional (apenas estrutura preparada).
- Animações (serão tratadas em change específica).
- Qualquer nova funcionalidade de usuário final.

## Decisions

### 1. Fonte empacotada em assets (vs google_fonts)

**Escolha: empacotar Nunito em assets**

Justificativa: o app é 100% offline (constituição definida no project.md). O pacote `google_fonts` baixa a fonte da internet na primeira execução, o que:
- Viola o princípio offline.
- Causa latência na primeira renderização (flash de texto invisível).
- Depende de disponibilidade de rede.

Empacotar os arquivos .ttf em `assets/fonts/` e registrá-los no `pubspec.yaml` garante que a fonte está disponível instantaneamente, sem rede, e é a abordagem mais coerente com a constituição do projeto.

### 2. Conversão oklch → Color do Flutter

Os valores oklch fornecidos pelo design foram convertidos usando a fórmula:
- `L` (0-100%) → `luminosity` 0.0-1.0
- `C` (0-100%) → `chroma` 0.0-1.0
- `H` (0-360) → `hue` em graus

No Flutter, `Color.from(Oklch)` está disponível via `Color.from(alpha: 1.0, luminance: L, chroma: C, hue: H)` usando o espaço de cor Oklch nativo. Alternativamente, podemos usar o construtor `Color.from(luminance:, chroma:, hue:)` no Flutter 3.10+.

**Tabela de conversão:**

| Token | oklch | Color Flutter |
|---|---|---|
| Fundo externo | oklch(93% 0.006 75) | Color.from(alpha: 1.0, luminance: 0.93, chroma: 0.006, hue: 75) |
| Superfície da tela | oklch(97% 0.012 75) | Color.from(alpha: 1.0, luminance: 0.97, chroma: 0.012, hue: 75) |
| Header/superfície clara/cartão | oklch(99% 0.006 75) | Color.from(alpha: 1.0, luminance: 0.99, chroma: 0.006, hue: 75) |
| Borda suave 1 | oklch(90% 0.015 75) | Color.from(alpha: 1.0, luminance: 0.90, chroma: 0.015, hue: 75) |
| Borda suave 2 | oklch(88% 0.02 75) | Color.from(alpha: 1.0, luminance: 0.88, chroma: 0.02, hue: 75) |
| Texto principal | oklch(32% 0.02 260) | Color.from(alpha: 1.0, luminance: 0.32, chroma: 0.02, hue: 260) |
| Texto principal escuro | oklch(30% 0.02 260) | Color.from(alpha: 1.0, luminance: 0.30, chroma: 0.02, hue: 260) |
| Texto secundário | oklch(52% 0.02 260) | Color.from(alpha: 1.0, luminance: 0.52, chroma: 0.02, hue: 260) |
| Texto secundário alto | oklch(55% 0.02 260) | Color.from(alpha: 1.0, luminance: 0.55, chroma: 0.02, hue: 260) |
| Azul marca (botão primário) | oklch(72% 0.07 235) | Color.from(alpha: 1.0, luminance: 0.72, chroma: 0.07, hue: 235) |
| Azul marca hover | oklch(74% 0.06 235) | Color.from(alpha: 1.0, luminance: 0.74, chroma: 0.06, hue: 235) |
| Azul texto/detalhe 1 | oklch(45% 0.03 235) | Color.from(alpha: 1.0, luminance: 0.45, chroma: 0.03, hue: 235) |
| Azul texto/detalhe 2 | oklch(48% 0.03 235) | Color.from(alpha: 1.0, luminance: 0.48, chroma: 0.03, hue: 235) |
| Azul texto/detalhe 3 | oklch(50% 0.06 235) | Color.from(alpha: 1.0, luminance: 0.50, chroma: 0.06, hue: 235) |
| Azul escuro (hover/link) | oklch(40% 0.09 235) | Color.from(alpha: 1.0, luminance: 0.40, chroma: 0.09, hue: 235) |
| Rosa suave (logo) | oklch(85% 0.06 15 / 0.75) | Color.from(alpha: 0.75, luminance: 0.85, chroma: 0.06, hue: 15) |
| Sombra | oklch(30% 0.02 260 / 0.18) | Color.from(alpha: 0.18, luminance: 0.30, chroma: 0.02, hue: 260) |

**Nota:** O construtor `Color.from(luminance:, chroma:, hue:)` está disponível no Flutter 3.10+. O projeto usa SDK ^3.12.2, então é seguro. A conferência visual contra o mockup deve ser feita durante a implementação — se algum tom desviar significativamente, ajustar manualmente.

### 3. Estrutura do tema

O tema é definido em uma única classe `AppTheme` com:
- **Método `token()`**: retorna um objeto `DesignTokens` com todas as cores, text styles, radii, shadows e spacings. Isso permite acesso programático aos tokens sem depender do `Theme.of(context)` quando necessário (ex.: em testes isolados).
- **Método `regular()`**: constrói o `ThemeData` completo a partir dos `DesignTokens`.
- **Método `highContrast()`**: placeholder para futuro (atualmente retorna `regular()`).

`DesignTokens` é uma classe separada que contém todos os tokens como constantes, servindo como única fonte de verdade:

```
DesignTokens
├── colors (cores nomeadas)
├── textStyles (TextStyle por papel tipográfico)
├── radii (BorderRadiusGeometry)
├── shadows (List<BoxShadow>)
└── spacing (double para gaps/paddings)
```

### 4. Migração de widgets compartilhados

**CardTile** (`lib/widgets/card_tile.dart`):
- `borderRadius`: migrar de `16` para `DesignTokens.radiusCard`.
- `elevation`: migrar de `1` para usar `DesignTokens.shadows.card` (sombra difusa).
- `splashColor` / `highlightColor`: usar `DesignTokens.colors.brand.withValues(alpha: 0.15/0.08)`.
- `padding`: usar `DesignTokens.spacing.sm` ou similar.
- `minHeight`/`minWidth`: manter `80x80` (≥ 44 dp).
- `TextStyle` do rótulo: usar `DesignTokens.textStyles.cardLabel`.

**SentenceBar** (`lib/widgets/sentence_bar.dart`):
- `borderRadius`: migrar para `DesignTokens.radiusBar`.
- `border`: usar `DesignTokens.colors.borderSoft`.
- `padding`: usar `DesignTokens.spacing.sm`.
- `barHeight`: manter calculado por `compact` (valores funcionais, não puramente visuais).
- `TextStyle` do placeholder: usar `DesignTokens.textStyles.caption`.

**MiniCard** (widget privado em `sentence_bar.dart`):
- `borderRadius`: migrar para `DesignTokens.radiusMini`.
- `border`: usar `DesignTokens.colors.borderSoft`.
- `TextStyle`: usar `DesignTokens.textStyles.caption`.

### 5. Botões no tema

**ElevatedButton (primário, azul preenchido):**
- `backgroundColor`: `DesignTokens.colors.brand`.
- `foregroundColor`: `DesignTokens.colors.surfaceCard`.
- `minimumSize`: `Size(double.infinity, 56)`.
- `shape`: `RoundedRectangleBorder(borderRadius: DesignTokens.radiusButton)`.
- `textStyle`: `DesignTokens.textStyles.button`.

**OutlinedButton (secundário, contorno):**
- `foregroundColor`: `DesignTokens.colors.brand`.
- `side`: `BorderSide(color: DesignTokens.colors.brand)`.
- `minimumSize`: `Size(double.infinity, 56)`.
- `shape`: `RoundedRectangleBorder(borderRadius: DesignTokens.radiusButton)`.
- `textStyle`: `DesignTokens.textStyles.button`.

### 6. Baixa carga sensorial — como o design respeita

- Cores suaves: o fundo externo tem croma 0.006 (quase acinzentado), sem saturação alta.
- Superfície clara (L=97%-99%) reduz contraste agressivo.
- Azul da marca com croma 0.07 (moderado, não vibrante).
- Rosa com alpha 0.75 (translúcido, suave).
- Sombras difusas (usando blurRadius, sem bordas duras).
- Raios de canto grandes (18-24px para cartões) eliminam pontas agressivas.
- Nunito é uma fonte arredondada, amigável, de alta legibilidade.

## Risks / Trade-offs

- **[Compatibilidade de versão]** `Color.from(luminance:, chroma:, hue:)` requer Flutter 3.10+. Projeto usa SDK ^3.12.2 — sem risco.
- **[Precisão de cor]** A conversão oklch → Color pode ter pequena variação visual versus o mockup original. **Mitigação:** conferência visual durante implementação com ajuste manual se necessário.
- **[Tamanho do APK]** Empacotar 4 pesos de Nunito adiciona ~100-150KB ao APK. Aceitável para um app offline que não baixa nada.
- **[Widgets migrados parcialmente]** Widgets de tela específica (home_screen, converse_screen) ainda podem ter valores hardcoded. **Mitigação:** eles consomem `Theme.of(context)` existente, então as cores do tema já atualizam automaticamente. Raios e padding de tela são tratados em changes futuras.
