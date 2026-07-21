## Context

O app usa o logo `assets/logo.png` (balão de fala sorridente, 140x140) em três telas: SplashScreen (centralizado), HomeScreen (centralizado, 120x120), e ConverseScreen (apenas texto no estado vazio). O logo é exibido como `Image.asset` sem nenhuma animação. Não há um widget compartilhado — cada tela importa a asset diretamente.

O sistema de acessibilidade já expõe `MediaQuery.disableAnimations` no SplashScreen, mas não há um mecanismo centralizado para respeitar redução de movimento.

## Goals / Non-Goals

**Goals:**
1. Criar `BalôWidget` — widget reutilizável que encapsula a asset + animações
2. Adicionar animação de respiração no Splash (scale, ciclo 3s)
3. Adicionar aceno sutil na Home (rotate -2°/+2°, 1x ao entrar)
4. Adicionar pulso gentil ao falar no ConverseScreen
5. Exibir Balô + texto em estados vazios
6. Respeitar `MediaQuery.disableAnimations` em todas as animações

**Non-Goals:**
- Não adicionar Lottie, Rive ou qualquer dependência de animação externa
- Não criar expressões faciais (sorriso, piscada — apenas movimentos de transform)
- Não adicionar som ao Balô
- Não gamificar (sem pontos, streaks, recompensas)
- Não modificar o logo ou assets existentes

## Decisions

### D1 — Widget único vs. lógica espalhada

**Decisão:** Um `BalôWidget` reutilizável que aceita parâmetros de animação opcionais. Cada tela decide qual animação ativar.

**Alternativa considerada:** Provider central de estado do Balô. Rejeitado porque as animações são independentes por tela e não precisam de estado compartilhado.

### D2 — Animações nativas vs. Lottie

**Decisão:** `AnimationController` nativo do Flutter.

**Motivo:** As animações são simples (scale, rotate, fade). Lottie adicionaria ~200KB+ por asset e complexidade de tooling sem benefício.

### D3 — API do BalôWidget

```dart
class BalôWidget extends StatefulWidget {
  final double size;           // tamanho do Balô (padrão 120)
  final BaloAnimation animation; // qual animação ativar
  final VoidCallback? onTap;   // callback opcional de toque
  final String? emptyMessage;  // se fornecido, exibe abaixo do Balô
}
```

Enum `BaloAnimation`:
- `none` — estático (sem animação)
- `breathing` — respiração contínua (splash)
- `wave` — aceno 1x ao construir (home)
- `pulse` — pulso único via `GlobalKey` (converse, ao falar)

### D4 — Pulso no ConverseScreen

O pulso será ativado observando o `speakingIndexProvider`. Quando `speakingIndex` muda de `null` para `0` (início da fala), o Balô dispara o pulso. Uma `GlobalKey` no `BalôWidget` permite chamar `startPulse()` externamente.

## Risks / Trade-offs

- **[Risk] Acaso na Home pode repetir em rebuilds:** mitigado com flag `_hasWaved` no estado do widget
- **[Risk] Pulso colide com fala da criança:** o pulso é visual (scale), não sonoro, e dura 400ms — não interfere com TTS
- **[Risk] Criança com epilepsia fotossensível:** as animações são extremamente sutis (2-5% de escala, ciclos lentos de 3s) e respeitam `disableAnimations`. Risco mínimo.
