## Why

O app Diga Lá atualmente inicia diretamente na tela Início, sem qualquer apresentação ou transição de abertura. Uma splash screen calma e acolhedora melhora a percepção de carregamento e estabelece a identidade visual do app desde o primeiro instante, alinhada ao princípio de baixa carga sensorial — sem pressa, sem informação abrupta. Esta change insere uma splash que exibe o símbolo do balão, o nome "Diga Lá" e o subtítulo, com avanço automático ou por toque.

## What Changes

- **Nova tela SplashScreen** como primeira rota do app (`/splash`), antes do Início.
- Exibe o logo (asset existente `assets/logo.png`) centralizado, com "Diga Lá" (Nunito w800) e "Comunicação que aproxima" (tonalidade secundária), usando tokens do tema visual-system.
- Avanço automático via timer (~2s) para a tela Início.
- Avanço imediato ao tocar na tela (cancela o timer).
- Transição suave (fade sutil) entre splash e Início, respeitando redução de movimento.
- Rota `/` redirecionada para `/splash` (a splash é a nova entrada).

## Capabilities

### New Capabilities
- `splash-screen`: Tela de abertura com logo, nome, subtítulo, timer de avanço, toque para pular, e transição suave para a tela Início.

### Modified Capabilities
- Nenhuma — as specs existentes não têm seus requisitos alterados. A rota inicial do app muda (`/` → `/splash`) mas o fluxo funcional do Início permanece idêntico.

## Impact

- `lib/screens/splash_screen.dart`: novo widget da splash.
- `lib/app.dart`: `initialRoute` muda para `/splash`; nova rota adicionada; rota `/` mantida para referência (HomeScreen).
- `test/screens/splash_screen_test.dart`: novos testes para conteúdo e navegação.
- Nenhuma dependência nova necessária.
- Nenhuma alteração em widgets compartilhados, tema, ou modelos de dados.
