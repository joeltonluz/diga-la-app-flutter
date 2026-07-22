## Why

O mascote Balô (balão de fala sorridente) já está presente na HomeScreen com
uma animação de balanço ao entrar na tela, mas depois desse aceno inicial ele
fica completamente estático. Um mascote que nunca pisca parece "de vidro" —
perde a sensação de acolhimento. Piscadas sutis e aleatórias dão vida ao Balô
sem quebrar a baixa carga sensorial, e tornam o toque no mascote uma
brincadeira de causa e efeito para a criança.

## What Changes

1. **Novo widget `BaloMascote`:** substitui o `BaloWidget` na HomeScreen.
   Internamente executa o balanço inicial (wave) e, após seu término, inicia um
   ciclo contínuo de piscadas aleatórias.
2. **Três assets de piscada** (`logo-blink-both`, `logo-blink-left`,
   `logo-blink-right`) em `assets/feelings/`, alternados com o neutro
   (`assets/logo.png`) durante a piscada.
3. **Piscada aleatória:** a cada ciclo, escolhe entre os três tipos de piscada
   e a exibe por ~120ms.
4. **Intervalo aleatório entre piscadas:** entre 4 e 15 segundos, simulando
   um padrão natural.
5. **Toque no Balô:** a criança pode tocar no mascote para fazê-lo piscar
   imediatamente (resposta variada entre os três tipos). Toques consecutivos
   reiniciam a piscada em vez de enfileirar.
6. **Registro dos assets de feelings no `pubspec.yaml`** e pré-carregamento
   (`precacheImage`) ao montar o widget.
7. **Tudo desligável:** respeitar `MediaQuery.disableAnimations` (acessibilidade).

## Capabilities

### ADDED Capabilities
- `balo-blink`: Widget `BaloMascote` reutilizável com ciclo de piscadas
  aleatórias + resposta ao toque, respeitando redução de movimento

### Modified Capabilities
- `mascote-balo` (existente): o `Balowidget` continua existindo, mas a
  HomeScreen passa a usar `BaloMascote` no lugar de `Balowidget(animation: BaloAnimation.wave)`

## Impact

- **Novo arquivo:** `lib/widgets/balo_mascote.dart` — widget do mascote com
  piscadas
- **Novo diretório de assets:** `assets/feelings/` (já existe com os arquivos,
  mas precisa ser registrado no `pubspec.yaml`)
- **Arquivos modificados:**
  - `pubspec.yaml` — adicionar `assets/feelings/`
  - `lib/screens/home_screen.dart` — trocar `Balowidget` por `BaloMascote`
  - `lib/widgets/balo_mascote.dart` — novo widget (criado)
- **Novos testes:**
  - `test/widgets/balo_mascote_test.dart`
- **Nenhuma dependência nova** — timers e animações nativos do Flutter
- **Nenhuma alteração nos providers, navegação ou modelo de dados**
