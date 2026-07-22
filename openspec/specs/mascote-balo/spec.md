## Purpose

Mascote Balô widget for the app, providing a reusable animated logo component with configurable animations (breathing, wave, pulse) and integrations across screens.

## Requirements

### Requirement: Widget reutilizável BalôWidget

O sistema DEVE fornecer um widget `BalôWidget` que encapsule o logo `assets/logo.png` com animações nativas configuráveis via parâmetros. O widget DEVE aceitar `size`, `BaloAnimation`, `onTap` e `emptyMessage` opcionais.

#### Scenario: Renderiza Balô com tamanho padrão
- **WHEN** `BalôWidget()` é inserido sem parâmetros
- **THEN** exibe o logo com 120x120px e sem animação

#### Scenario: Renderiza Balô com tamanho customizado
- **WHEN** `BalôWidget(size: 80)` é inserido
- **THEN** exibe o logo com 80x80px

#### Scenario: Renderiza Balô com emptyMessage
- **WHEN** `BalôWidget(emptyMessage: "Toque nos cartões")` é inserido
- **THEN** exibe o logo acima do texto "Toque nos cartões"

#### Scenario: Callback onTap é chamado ao tocar
- **WHEN** usuário toca no Balô
- **THEN** `onTap` é chamado

### Requirement: Animação breathing (respiração contínua)

Quando `BaloAnimation.breathing` estiver ativo, o Balô DEVE oscilar suavemente entre `scale 1.0` e `scale 1.02` com duração de ciclo de 3 segundos, em loop infinito, com `Curves.easeInOut`.

#### Scenario: Breathing loop infinito
- **WHEN** `BalôWidget(animation: BaloAnimation.breathing)` é inserido
- **THEN** o Balô escala entre 1.0 e 1.02 continuamente, ciclo de 3s

#### Scenario: Breathing desliga com disableAnimations
- **WHEN** `MediaQuery.disableAnimations` é true
- **THEN** Balô permanece estático mesmo com `BaloAnimation.breathing`

### Requirement: Animação wave (aceno único)

Quando `BaloAnimation.wave` estiver ativo, o Balô DEVE rotacionar entre -2° e +2° exatamente 1 vez ao ser construído, com duração de 1 segundo, usando `Curves.easeInOut`.

#### Scenario: Wave executa uma vez na construção
- **WHEN** `BalôWidget(animation: BaloAnimation.wave)` é inserido
- **THEN** o Balô rotaciona entre -2° e +2° uma única vez, duração 1s

#### Scenario: Wave não repete em rebuilds
- **WHEN** o widget pai faz rebuild
- **THEN** o aceno não se repete (flag `_hasWaved` impede repetição)

### Requirement: Animação pulse (pulso gentil ao falar)

O Balô DEVE expor um método `startPulse()` via `GlobalKey` que executa escala de 1.0 → 1.05 → 1.0 com duração total de 400ms, `Curves.easeOut`.

#### Scenario: Pulse é disparado externamente
- **WHEN** `baloKey.currentState?.startPulse()` é chamado
- **THEN** Balô escala para 1.05 e retorna a 1.0 em 400ms

### Requirement: Integração no SplashScreen

O SplashScreen DEVE substituir `Image.asset('assets/logo.png')` por `BalôWidget` com `BaloAnimation.breathing`.

#### Scenario: Splash exibe Balô respirando
- **WHEN** usuário abre o app
- **THEN** Balô aparece com respiração contínua na splash

### Requirement: Integração na HomeScreen

A HomeScreen DEVE substituir `Image.asset('assets/logo.png')` por `BalôWidget` com `BaloAnimation.wave`.

#### Scenario: Home exibe Balô com aceno
- **WHEN** splash transiciona para home
- **THEN** Balô executa aceno uma vez

### Requirement: Integração no ConverseScreen

O ConverseScreen DEVE:
- Substituir o texto vazio por `BalôWidget` com `emptyMessage` traduzido
- Observar `speakingIndexProvider` e disparar `startPulse()` quando a fala iniciar

#### Scenario: Estado vazio mostra Balô com mensagem
- **WHEN** não há cartões na frase (`sentenceCards.isEmpty`)
- **THEN** exibe Balô com texto "Toque nos cartões para montar uma frase"

#### Scenario: Pulso ao falar
- **WHEN** usuário aperta "Falar" e `speakingIndex` muda de `null` para `0`
- **THEN** Balô executa pulso de 400ms
