## Context

A tela SettingsScreen atual foi construída antes da centralização dos DesignTokens e do padrão visual das demais telas. Ela usa `theme.colorScheme.primary`, `theme.colorScheme.onSurface.withValues(alpha: ...)` e `theme.textTheme` diretamente — o que a faz destoar das telas refatoradas (HomeScreen, LearnScreen, CategoryGridScreen, ConverseScreen) que consomem DesignTokens.

O mockup define:
- AppBar com botão voltar circular (mesmo `Icons.arrow_back_rounded` das outras telas)
- Cartões de idioma com fundo brand claro + borda brand / fundo surfaceCard + borda borderSoft
- Seção Voz como linhas compactas (não cards) com rádio, nome, botão "Ouvir" e divisor
- Seção Velocidade no mesmo estilo de linha, coerente com Voz
- Tudo usando as cores, tipografia, radii e spacing do DesignTokens

## Goals / Non-Goals

**Goals:**
- Refatorar visual da SettingsScreen para usar exclusivamente DesignTokens
- Adicionar botão voltar no AppBar (consistência com LearnScreen, CategoryGridScreen)
- Cartões de idioma: brand/borderSoft conforme selecionado
- Seção Voz: de cards para linhas com rádio + nome + Ouvir + divisor borderSoft
- Seção Velocidade: mesmo padrão de linha
- TDD: expandir testes existentes antes de implementar

**Non-Goals:**
- Alterar lógica de idioma/voz/velocidade (já implementada e testada)
- Adicionar novas configurações
- Modularizar em widgets reutilizáveis (pode ficar como widgets privados no mesmo arquivo)

## Decisions

1. **Linhas em vez de cards para Voz e Velocidade**
   - O mockup mostra linhas compactas com divisor, não cartões individuais.
   - Isso diferencia visualmente as seções: idioma em cards grandes (escolha principal), voz e velocidade em linhas (escolhas secundárias).
   - O rádio fica à esquerda (diferente dos cards de idioma, onde fica à direita) por legibilidade em lista.

2. **DesignTokens puros, sem fallback para Theme**
   - Todas as cores: `DesignTokens.colors.*`
   - Tipografia: `DesignTokens.textStyles.*`
   - Cantos: `DesignTokens.radii.*`
   - Espaçamento: `DesignTokens.spacing.*` (apesar de manter EdgeInsets literais por ora)
   - Única exceção: `Theme.of(context).colorScheme` para cores que dependem do tema dinâmico (ex.: fundo do AppBar). Mas como o tema já foi configurado para usar DesignTokens internamente, na prática resolve igual.

3. **Rádio personalizado (círculo pintado via Container)**
   - Em vez de `Radio` widget do Material, usar `Container` circular com borda/fill.
   - Mesmo padrão já usado no _ModeCard atual — apenas ajustar cores para DesignTokens.
   - Evita dependência de ThemeData para cor do rádio.

4. **Seção com label em brand**
   - O título "Voz" e "Velocidade" usam brand como cor, em `bodySmall` ou `caption` (mockup mostra label pequeno).
   - O título "Idioma de fala" continua como `headlineMedium` ou `titleLarge` em textPrimary (seção principal).
   - Descrições das seções em textSecondary.
   - Isso segue o princípio de hierarquia visual do mockup.

5. **Botão "Ouvir" como IconButton secundário**
   - `Icons.play_circle_outline_rounded` com cor brand (não primary do tema).
   - Mesmo estilo do IconButton usado em ConverseScreen/CardTile.

## Risks / Trade-offs

- **Risco:** Ao mudar de cards para linhas com divisor, reduz-se a área de toque de cada voz/velocidade. **Mitigação:** Manter padding vertical generoso (>= 12dp em cada linha) e o rádio + nome + botão são todos tocáveis. A linha inteira continua sendo um GestureDetector.
- **Trade-off:** Manter widgets privados no mesmo arquivo (vs. extrair para novos arquivos). O arquivo settings_screen.dart tem ~500 linhas — após a refatoração deve reduzir. Se crescer demais no futuro, extrair para `lib/widgets/settings/` (fora de escopo agora).

## Open Questions

- Nenhuma.
