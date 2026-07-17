## Context

O app Diga Lá inicia diretamente na tela Início (`/`), sem qualquer transição de abertura. Com o visual-system implementado (Nunito, tokens de cor, raios, sombras), a identidade visual está pronta — falta uma splash que apresente o app de forma calma e acolhedora antes da primeira interação.

O projeto exige **baixa carga sensorial**: nada de animações chamativas, flashes, ou delays irritantes. A splash precisa ser suave, rápida de pular, e coerente com o branding existente (logo, nome, subtítulo).

## Goals / Non-Goals

**Goals:**
- Tela de splash como nova primeira rota (`/splash`).
- Exibir logo `assets/logo.png` centralizado, "Diga Lá" (Nunito w800, cor texto principal), "Comunicação que aproxima" (Nunito w400, cor texto secundário).
- Avanço automático para Início após ~2 segundos.
- Avanço imediato ao tocar na tela (cancela o timer em execução).
- Transição suave: fade sutil entre splash e Início.
- Respeitar redução de movimento do sistema (nada de animações se `disableAnimations` true).
- Todos os tokens visuais vindos do `DesignTokens` / `AppTheme` do visual-system.

**Non-Goals:**
- Splash nativa do Android (`flutter_native_splash`) — será configurada em change separada se desejado.
- Lógica de "primeira vez" / onboarding / tutorial.
- Animações elaboradas ou parallax.
- Alterações em outras telas, tema, ou fluxos de navegação internos.
- Novas dependências (a splash usa apenas Flutter SDK e assets existentes).

## Decisions

### 1. Timer de avanço: 2 segundos (vs 1.5s ou 2.5s)

**Escolha: 2.0s**

Justificativa: tempo suficiente para o usuário perceber o logo e o nome (reforço de branding), mas curto o bastante para não causar impaciência ou sensação de travamento. A OMS recomenda máximo de 2-3s para splash screens em apps de saúde/inclusão. O usuário pode pular a qualquer momento tocando.

### 2. Avanço por toque vs. automático: ambos coexistem sem conflito

O timer é armazenado como `Timer?` e cancelado no `dispose()` do StatefulWidget. Se o usuário tocar antes do timer expirar:
- O timer é cancelado (`timer?.cancel()`).
- A navegação ocorre imediatamente.
- O `dispose()` não tenta cancelar um timer já cancelado (null-safe).

### 3. Logo reusado do asset existente

O logo `assets/logo.png` (120x120) já está no app e foi projetado com o balão sorridente, olhos e bochechas. Reusá-lo evita recompor o símbolo com CustomPainter ou formas separadas. O tamanho do logo na splash é 120x120 (mesmo da Home), centralizado.

### 4. Transição suave sem dependências

Usar `Navigator.pushReplacement` com `PageRouteBuilder` e uma animação de fade (`Opacity` via `Tween(begin: 1.0, end: 0.0)` para a splash, e `Tween(begin: 0.0, end: 1.0)` para a home). Isso é nativo do Flutter, sem dependências externas. Se `MediaQuery.disableAnimations` for true, pular a animação (navegação sem transição).

### 5. Estrutura: StatefulWidget com Timer

A splash precisa de timer + detecção de toque. `StatefulWidget` é a escolha natural:
- `initState()`: inicia o timer com duração de 2s e um callback de navegação.
- `build()`: `GestureDetector` envolvendo um `Scaffold` (ou `Container` full-screen) com fundo do token de superfície, logo centralizado, nome e subtítulo.
- O `GestureDetector.onTap` chama `_navigateToHome()` que cancela o timer e faz a navegação.
- `dispose()`: cancela o timer se ainda ativo.

### 6. Rotas no app.dart

- `initialRoute: '/splash'`
- Rota `'/splash'`: `SplashScreen`
- Rota `'/'`: `HomeScreen` (inalterada)
- A splash redireciona para `'/'` via `Navigator.pushReplacementNamed`

## Risks / Trade-offs

- **[Timer não cancelado]** Se o usuário navegar para Início por toque e depois o timer expirar, pode tentar navegar de novo causando conflito. **Mitigação:** o timer é cancelado no `_navigateToHome()` antes da navegação, e o `dispose()` confirma o cancelamento.
- **[Transição flash]** Se a animação de fade for mal feita, pode piscar. **Mitigação:** usar `PageRouteBuilder` com `transitionDuration` de 400ms, fade cruzado (cross-fade) em vez de fade-out seguido de fade-in.
- **[Redução de movimento]** Se `MediaQuery.disableAnimations` for true, a `PageRouteBuilder` ainda roda a animação. **Mitigação:** verificar a preferência antes de construir a rota; se true, usar `MaterialPageRoute` sem animação.
