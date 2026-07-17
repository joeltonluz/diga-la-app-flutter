## ADDED Requirements

### Requirement: AppBar da LearnScreen tem botão voltar e título "Aprender"
O AppBar da LearnScreen DEVE ter um botão voltar circular à esquerda e o título centralizado "Aprender" (não "Modo Aprender").

#### Scenario: AppBar exibe título Aprender
- **WHEN** o usuário navega para a LearnScreen
- **THEN** o título do AppBar é "Aprender"
- **AND** há um botão voltar circular visível

#### Scenario: Botão voltar retorna ao Início
- **WHEN** o usuário toca no botão voltar no AppBar da LearnScreen
- **THEN** o app navega de volta para a HomeScreen

### Requirement: Grade de categorias tem 2 colunas fixas
A grade de categorias na LearnScreen DEVE ter exatamente 2 colunas em qualquer orientação (portrait ou landscape). Cada card de categoria DEVE usar emoji grande centralizado e nome com estilo `titleLarge`/`cardLabel`, com `radii.card`, `surfaceCard` e `shadows.card`.

#### Scenario: Grade tem 2 colunas
- **WHEN** a LearnScreen é renderizada em portrait
- **THEN** a GridView tem crossAxisCount igual a 2

#### Scenario: Grade tem 2 colunas em landscape
- **WHEN** a LearnScreen é renderizada em landscape
- **THEN** a GridView tem crossAxisCount igual a 2

### Requirement: AppBar da CategoryGridScreen tem botão voltar
O AppBar da CategoryGridScreen DEVE ter um botão voltar circular à esquerda e o título igual ao nome da categoria centralizado.

#### Scenario: AppBar exibe nome da categoria
- **WHEN** o usuário abre uma categoria
- **THEN** o título do AppBar é o nome da categoria
- **AND** há um botão voltar circular visível

#### Scenario: Botão voltar retorna às categorias
- **WHEN** o usuário toca no botão voltar na CategoryGridScreen
- **THEN** o app retorna à LearnScreen

### Requirement: Grade de itens tem 3 colunas fixas
A grade de itens na CategoryGridScreen DEVE ter exatamente 3 colunas em qualquer orientação. Cada item DEVE usar o widget `CardTile` compartilhado.

#### Scenario: Grade tem 3 colunas
- **WHEN** a CategoryGridScreen é renderizada
- **THEN** a GridView tem crossAxisCount igual a 3
