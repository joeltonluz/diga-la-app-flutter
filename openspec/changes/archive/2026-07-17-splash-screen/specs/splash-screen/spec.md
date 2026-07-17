## ADDED Requirements

### Requirement: Splash exibe logo, nome e subtítulo
A tela de splash DEVE exibir:
- O logo do app (`assets/logo.png`) centralizado horizontalmente
- O texto "Diga Lá" abaixo do logo, usando Nunito w800 e cor de texto principal (DesignTokens.colors.textPrimary)
- O texto "Comunicação que aproxima" abaixo do nome, usando cor de texto secundário (DesignTokens.colors.textSecondary) e peso w400
- Fundo usando a cor de superfície da tela (DesignTokens.colors.surfaceScreen)

#### Scenario: Splash exibe o nome e subtítulo
- **WHEN** a splash é renderizada
- **THEN** o texto "Diga Lá" está visível na tela
- **AND** o texto "Comunicação que aproxima" está visível na tela
- **AND** o logo está visível na tela

#### Scenario: Splash usa tokens de texto do tema
- **WHEN** a splash é renderizada
- **THEN** o estilo de "Diga Lá" usa fontFamily 'Nunito' e fontWeight w800
- **AND** o estilo de "Comunicação que aproxima" usa fontWeight w400

### Requirement: Avanço automático após tempo definido
A splash DEVE avançar para a tela Início automaticamente após 2 segundos (tolerância de 100ms).

#### Scenario: Splash navega automaticamente para Início
- **WHEN** o tempo definido (2s) é atingido
- **THEN** a rota atual é substituída pela tela Início (`/`)
- **AND** o timer interno é cancelado

#### Scenario: Timer é cancelado ao sair da splash
- **WHEN** a splash é removida da árvore de widgets (dispose)
- **THEN** o timer de avanço automático é cancelado
- **AND** nenhuma navegação ocorre após o descarte

### Requirement: Avanço imediato ao tocar na tela
O usuário DEVE poder pular a splash tocando em qualquer lugar da tela, navegando imediatamente para o Início.

#### Scenario: Toque na splash navega para Início
- **WHEN** o usuário toca na tela da splash
- **THEN** a navegação para a tela Início ocorre imediatamente
- **AND** o timer de avanço automático é cancelado

#### Scenario: Timer não dispara após toque
- **WHEN** o usuário toca na splash antes do timer expirar
- **THEN** a splash navega para o Início
- **AND** o timer não dispara posteriormente (foi cancelado)

### Requirement: Transição suave e respeita redução de movimento
A transição da splash para o Início DEVE usar fade cruzado suave (cross-fade). Se o sistema indicar preferência por redução de movimento (`MediaQuery.disableAnimations`), a transição DEVE ocorrer sem animação.

#### Scenario: Transição usa cross-fade
- **WHEN** a splash navega para o Início
- **THEN** a transição usa cross-fade com duração de ~400ms

#### Scenario: Redução de movimento pula animação
- **WHEN** o sistema tem `disableAnimations` true
- **THEN** a navegação da splash para o Início não tem animação

### Requirement: Splash é a primeira rota do app
O app DEVE iniciar na splash (`/splash`) em vez de iniciar diretamente no Início.

#### Scenario: Rota inicial é a splash
- **WHEN** o app é iniciado
- **THEN** a primeira tela exibida é a splash
- **AND** a rota atual é `/splash`

#### Scenario: Início permanece acessível em `/`
- **WHEN** a splash navega
- **THEN** a rota `'/'` leva à HomeScreen (inalterada)
