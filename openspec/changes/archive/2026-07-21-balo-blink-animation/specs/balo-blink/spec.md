## ADDED Requirements

### Requirement: Widget BaloMascote reutilizável
O sistema DEVE fornecer um widget `BaloMascote` que exiba o Balô com olhos
abertos (asset neutro `assets/logo.png`) e, após o término do balanço inicial,
inicie um ciclo contínuo de piscadas aleatórias.

#### Scenario: Renderiza asset neutro por padrão
- **GIVEN** um `BaloMascote()` é inserido na árvore
- **THEN** o asset exibido é `assets/logo.png`
- **AND** o tamanho padrão é 120x120dp

#### Scenario: Aceita tamanho customizado
- **GIVEN** `BaloMascote(size: 80)` é inserido
- **THEN** o asset é exibido com 80x80dp

### Requirement: Assets de piscada registrados
O `pubspec.yaml` DEVE incluir o diretório `assets/feelings/` para que os
assets de piscada sejam empacotados.

### Requirement: Pré-carregamento dos assets de piscada
O `BaloMascote` DEVE chamar `precacheImage` para cada asset de piscada
(`logo-blink-both.png`, `logo-blink-left.png`, `logo-blink-right.png`) durante
a construção, antes da primeira piscada.

#### Scenario: Assets são pré-carregados no initState
- **GIVEN** um `BaloMascote` é montado
- **THEN** os três assets de piscada são pré-carregados via `precacheImage`

### Requirement: Balanço inicial (wave)
O `BaloMascote` DEVE executar o mesmo balanço inicial do `BaloAnimation.wave`
ao ser construído. O ciclo de piscadas só DEVE iniciar APÓS o término desse
balanço.

#### Scenario: Piscada não começa antes do fim do balanço
- **GIVEN** um `BaloMascote` recém-montado
- **WHEN** o balanço inicial ainda está em execução
- **THEN** nenhuma piscada ocorre (asset neutro permanece)

#### Scenario: Primeira piscada ocorre após o balanço
- **GIVEN** um `BaloMascote` recém-montado
- **WHEN** o balanço inicial termina (`AnimationStatus.completed`)
- **THEN** o ciclo de piscadas é iniciado
- **AND** a primeira piscada ocorre após um intervalo aleatório entre 4 e 15s

### Requirement: Ciclo de piscadas aleatórias
O `BaloMascote` DEVE piscar em intervalos aleatórios, repetindo
indefinidamente enquanto a tela estiver ativa.

#### Scenario: Piscada troca asset por 120ms e retorna ao neutro
- **GIVEN** o ciclo de piscadas está ativo
- **WHEN** o timer de piscada dispara
- **THEN** o asset é trocado para um dos três tipos de piscada (aleatório)
- **AND** após 120ms o asset retorna a `assets/logo.png`
- **AND** um novo timer é agendado com intervalo aleatório entre 4 e 15s

#### Scenario: Tipo de piscada é aleatório
- **GIVEN** o ciclo de piscadas está ativo
- **WHEN** uma piscada ocorre
- **THEN** o asset escolhido está entre `logo-blink-both.png`,
  `logo-blink-left.png` ou `logo-blink-right.png`

### Requirement: Resposta ao toque
O Balô DEVE ser tocável: ao tocar, ele pisca imediatamente com tipo aleatório
e reagenda o próximo ciclo automático.

#### Scenario: Toque dispara piscada imediata
- **GIVEN** o `BaloMascote` está visível na tela
- **WHEN** o usuário toca no Balô
- **THEN** o Balô exibe uma piscada aleatória por 120ms
- **AND** o próximo ciclo automático é reagendado a partir do toque

#### Scenario: Toques consecutivos não enfileiram
- **GIVEN** o Balô está no meio de uma piscada (dentro dos 120ms)
- **WHEN** o usuário toca novamente
- **THEN** o timer de retorno ao neutro é reiniciado
- **AND** um novo tipo de piscada (aleatório) é exibido
- **AND** o cronômetro de 120ms recomeça

#### Scenario: toque em área ampla
- **GIVEN** um `BaloMascote` de 120x120dp
- **WHEN** o usuário toca em qualquer ponto dentro da área delimitada pelo
  `BaloMascote`
- **THEN** a piscada de resposta é disparada

### Requirement: Acessibilidade — redução de movimento
Quando `MediaQuery.disableAnimations` ou `MediaQuery.accessibleNavigation` for
true, o `BaloMascote` DEVE:
- Não executar o balanço inicial
- Não iniciar o ciclo de piscadas
- Não piscar ao toque

#### Scenario: Sem animação ao tocar com redução de movimento
- **GIVEN** `MediaQuery.disableAnimations` é true
- **WHEN** o usuário toca no `BaloMascote`
- **THEN** nenhuma piscada ocorre
- **AND** o `onTap` (se fornecido) ainda é chamado

### Requirement: Ciclo de vida — dispose
O `BaloMascote` DEVE cancelar todos os timers e AnimationControllers no
`dispose`.

#### Scenario: Timer é cancelado no dispose
- **GIVEN** um `BaloMascote` com ciclo de piscadas ativo
- **WHEN** o widget é desmontado
- **THEN** o timer de piscada é cancelado
- **AND** nenhum erro ocorre
- **AND** nenhum callback é chamado após o dispose

### Requirement: onTap callback
O `BaloMascote` DEVE aceitar um `onTap` opcional, disparado após a piscada de
resposta ao toque (ou imediatamente, se a redução de movimento estiver ativa).

#### Scenario: onTap é chamado ao tocar
- **GIVEN** `BaloMascote(onTap: () => doSomething())`
- **WHEN** o usuário toca no Balô
- **THEN** `doSomething()` é chamado após a troca de asset (ou imediatamente,
  se animations desligadas)

### Requirement: state — asset atual é rastreável
O `BaloMascote` DEVE expor o caminho do asset atualmente exibido para fins de
teste, por exemplo via `_BaloMascoteState.currentAsset`.

#### Scenario: Teste consegue ler o asset atual
- **GIVEN** um `BaloMascote` com `GlobalKey<_BaloMascoteState>`
- **WHEN** `key.currentState?.currentAsset` é lido
- **THEN** retorna o caminho do asset atualmente exibido
