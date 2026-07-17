## ADDED Requirements

### Requirement: HomeScreen titulo usa cor de texto principal
O texto "Diga La" na HomeScreen DEVE usar a cor de texto principal (textPrimary / onSurface), NAO a cor primaria (brand / primary).

#### Scenario: Titulo nao usa primary
- **WHEN** a HomeScreen e renderizada
- **THEN** o estilo do texto "Diga La" nao usa `colorScheme.primary` como cor

### Requirement: HomeScreen subtitulo nao tem emoji
O subtitulo na HomeScreen DEVE ser "Comunicacao que aproxima" (sem o emoji "🧩").

#### Scenario: Subtitulo sem emoji
- **WHEN** a HomeScreen e renderizada
- **THEN** o texto "Comunicacao que aproxima" esta visivel
- **AND** o emoji "🧩" nao esta presente

### Requirement: Botao "Aprender" e secundario (OutlinedButton)
O botao "Aprender" na HomeScreen DEVE ser do tipo `OutlinedButton` (contorno azul, texto azul), nao `ElevatedButton`.

#### Scenario: Botao Aprender e OutlinedButton
- **WHEN** a HomeScreen e renderizada
- **THEN** o widget do botao "Aprender" e um `OutlinedButton`
- **AND** o widget do botao "Conversar" e um `ElevatedButton`

### Requirement: Cartoes de categoria no Learn usam tokens do tema
Os cartoes de categoria no LearnScreen DEVEM usar `DesignTokens.radii.card`, `DesignTokens.colors.surfaceCard`, e `DesignTokens.shadows.card` (ou `CardTheme` do tema), sem valores fixos de borderRadius, elevation, ou color.

#### Scenario: Cartao de categoria usa borderRadius do tema
- **WHEN** a LearnScreen e renderizada
- **THEN** o `borderRadius` do cartao de categoria usa `DesignTokens.radii.card` (20)

### Requirement: Botoes secundarios no Converse usam tokens
Os botoes secundarios (voltar, lixeira) na ConverseScreen DEVEM usar cores do tema para fundo e icone, sem `Colors.transparent` ou `surfaceContainerHighest` soltos.

#### Scenario: Botao secundario usa cor do tema
- **WHEN** a ConverseScreen e renderizada com cartoes na frase
- **THEN** os botoes secundarios usam cor do tema para fundo e icone

### Requirement: Cards de selecao nas Settings usam borderRadius do tema
Os cards de selecao (_ModeCard, _VoiceCard, _RateCard) na SettingsScreen DEVEM usar `DesignTokens.radii.card` para borderRadius, nao valor fixo 20.

#### Scenario: Card de idioma usa borderRadius do tema
- **WHEN** a SettingsScreen e renderizada
- **THEN** o `_ModeCard` usa `DesignTokens.radii.card`
