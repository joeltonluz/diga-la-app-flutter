## ADDED Requirements

### Requirement: Tema expõe tokens de cores
O tema centralizado DEVE expor as seguintes cores como tokens acessíveis via `Theme.of(context).colorScheme` e/ou classe `DesignTokens`:
- Fundo externo (scaffold background)
- Superfície da tela
- Superfície clara / fundo de cartão
- Bordas suaves (dois níveis)
- Texto principal (dois níveis: normal e escuro)
- Texto secundário (dois níveis)
- Azul da marca (botão primário, seleção)
- Azul claro de texto/detalhe (três níveis)
- Azul escuro (hover/link)
- Rosa suave (detalhe do logo)
- Sombra difusa

#### Scenario: Cores do tema são acessíveis
- **WHEN** o teste instancia `AppTheme.regular()`
- **THEN** o `colorScheme` retorna cores correspondentes aos valores oklch definidos no design
- **AND** `primary` equivale ao azul marca `oklch(72% 0.07 235)`
- **AND** `surface` equivale ao fundo de cartão `oklch(99% 0.006 75)`
- **AND** `onSurface` equivale ao texto principal `oklch(32% 0.02 260)`

### Requirement: Tema expõe estilos de texto com Nunito
O tema centralizado DEVE expor estilos de texto usando a fonte Nunito com os seguintes pesos:
- displayLarge: w800, ~32sp (nome grande)
- headlineLarge: w800, ~24sp (título de tela)
- headlineMedium: w700, ~22sp
- titleLarge: w700, ~18sp (rótulo de cartão)
- bodyLarge: w600, ~16sp (corpo ênfase)
- bodyMedium: w400, ~15sp (corpo regular)
- bodySmall: w400, ~13sp (legenda)
- labelLarge: w800, ~20sp (botão principal)

#### Scenario: Estilos de texto usam Nunito
- **WHEN** o teste instancia `AppTheme.regular()`
- **THEN** `textTheme.displayLarge` usa `fontFamily` igual a 'Nunito' e `fontWeight` w800
- **AND** `textTheme.titleLarge` usa `fontFamily` igual a 'Nunito' e `fontWeight` w700
- **AND** `textTheme.bodyMedium` usa `fontFamily` igual a 'Nunito' e `fontWeight` w400

### Requirement: CardTile consome tokens do tema
O widget `CardTile` DEVE usar `Theme.of(context)` para todas as propriedades visuais:
- borderRadius: do token de raio de cartão
- elevation/sombra: do token de sombra de cartão
- splashColor/highlightColor: derivados do azul marca com alpha
- Estilo do rótulo: do textTheme.titleLarge ou token equivalente

#### Scenario: CardTile usa borderRadius do tema
- **WHEN** o widget `CardTile` é renderizado
- **THEN** o `Material` que envolve o cartão usa `borderRadius` igual a `AppTheme.tokens.radiusCard`

#### Scenario: CardTile usa sombra do tema
- **WHEN** o widget `CardTile` é renderizado
- **THEN** a sombra do cartão corresponde a `AppTheme.tokens.shadows.card` (difusa, discreta)

#### Scenario: CardTile usa estilo de texto do tema
- **WHEN** o widget `CardTile` é renderizado com um card
- **THEN** o estilo do rótulo usa `fontWeight` w700, `fontFamily` 'Nunito', e tamanho ~17-18sp

### Requirement: Botão primário usa tokens do tema
O `ElevatedButton` no tema DEVE usar:
- `backgroundColor`: azul marca
- `foregroundColor`: superfície clara (branco)
- `minimumSize`: altura 56dp, largura infinita
- `shape`: borderRadius do token de botão (18-24px)
- `textStyle`: fonte Nunito w800 ~20sp

#### Scenario: Botão primário tem altura mínima de 56dp
- **WHEN** um `ElevatedButton` é renderizado com o tema
- **THEN** o botão tem altura mínima de 56 dp

#### Scenario: Botão primário usa azul marca
- **WHEN** um `ElevatedButton` é renderizado com o tema
- **THEN** `backgroundColor` é igual ao azul marca definido nos tokens

### Requirement: Botão secundário usa tokens do tema
O `OutlinedButton` no tema DEVE usar:
- `foregroundColor`: azul marca
- `side`: borda com azul marca
- `minimumSize`: altura 56dp, largura infinita
- `shape`: borderRadius do token de botão

#### Scenario: Botão secundário tem borda azul marca
- **WHEN** um `OutlinedButton` é renderizado com o tema
- **THEN** a borda lateral (`side`) usa a cor azul marca

### Requirement: SentenceBar consome tokens do tema
O widget `SentenceBar` DEVE usar `Theme.of(context)` para borderRadius, border color, padding, e estilos de texto.

#### Scenario: SentenceBar usa borderRadius do tema
- **WHEN** o widget `SentenceBar` é renderizado
- **THEN** o `borderRadius` do container usa o token de raio definido no tema

#### Scenario: SentenceBar usa cor de borda do tema
- **WHEN** o widget `SentenceBar` é renderizado sem cartões
- **THEN** a cor da borda usa um dos tokens de borda suave definidos no tema

### Requirement: Alvos de toque mantêm tamanho mínimo
Todos os botões e cartões interativos DEVEM ter alvo de toque ≥ 44x44 dp.

#### Scenario: CardTile tem tamanho mínimo de toque
- **WHEN** `CardTile` é renderizado
- **THEN** as constraints mínimas são 80x80 (≥ 44x44 dp)

#### Scenario: ElevatedButton tem altura mínima 56dp
- **WHEN** um `ElevatedButton` é renderizado com o tema
- **THEN** `minimumSize.height` ≥ 56

### Requirement: Fontes Nunito empacotadas em assets
Os arquivos de fonte Nunito (pesos 400, 600, 700, 800) DEVEM estar em `assets/fonts/` e registrados no `pubspec.yaml` para uso offline.

#### Scenario: Nunito registrada no pubspec
- **WHEN** o `pubspec.yaml` é lido
- **THEN** contém referências aos arquivos Nunito-400, Nunito-600, Nunito-700, Nunito-800 em `assets/fonts/`

#### Scenario: Tema usa Nunito como fontFamily padrão
- **WHEN** `AppTheme.regular()` é instanciado
- **THEN** o tema usa 'Nunito' como `fontFamily` padrão
