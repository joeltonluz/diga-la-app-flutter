## Context

O mascote Balô aparece na HomeScreen usando `Balowidget(animation: BaloAnimation.wave)`,
que executa um balanço (rotação -0.5° a +0.5°) de 3,2s ao ser construído e depois
permanece estático. Já existem assets de piscada em `assets/feelings/` prontos:

- `logo-blink-both.png` — os dois olhos fechados
- `logo-blink-left.png` — olho esquerdo fechado
- `logo-blink-right.png` — olho direito fechado

O asset neutro (olhos abertos) é `assets/logo.png`, já registrado no `pubspec.yaml`.
Os assets de `assets/feelings/` ainda não estão registrados.

O `Balowidget` atual só suporta animações transform (scale, rotate) e não possui
mecanismo de troca de assets nem temporização aleatória. Um novo widget é
necessário para não acoplar lógica de timers/disparo aleatório ao widget
existente.

## Goals / Non-Goals

**Goals:**
1. Criar `BaloMascote` — widget stateful com ciclo de piscadas aleatórias
2. Executar o balanço inicial (reaproveitando a lógica do `Balowidget` ou
   implementando internamente) e, ao término, iniciar o ciclo de piscadas
3. Piscada aleatória entre os três tipos (both, left, right), duração ~120ms
4. Intervalo aleatório entre piscadas (4-15s) com distribuição uniforme
5. Toque no mascote dispara piscada imediata e reagenda o ciclo
6. Toques consecutivos rápidos: reiniciar a piscada em curso (não enfileirar)
7. Registrar `assets/feelings/` no `pubspec.yaml`
8. Pré-carregar os assets de piscada no `initState` via `precacheImage`
9. Cancelar timers e controllers no `dispose`
10. Respeitar `MediaQuery.disableAnimations` (não piscar nem ao toque)

**Non-Goals:**
- Não adicionar piscadas em outras telas (embora o widget seja reutilizável)
- Não criar estados emocionais (calmo, feliz, sonolento, surpreso)
- Não adicionar som ao toque
- Não modificar o `Balowidget` existente
- Não adicionar dependências externas

## Decisions

### D1 — Widget separado vs. estender Balowidget

**Decisão:** Criar `BaloMascote` como um widget novo e independente.

**Motivo:** A lógica de piscada (timers, troca de assets, resposta ao toque)
é ortogonal às animações transform do `Balowidget`. Misturá-las aumentaria a
complexidade do `Balowidget` sem benefício. `BaloMascote` pode internamente
reaproveitar um `AnimationController` para o balanço inicial.

### D2 — Asset switching vs. Overlay / composição

**Decisão:** Trocar o `Image.asset` por um novo caminho a cada piscada. Não
usar overlay nem composição de camadas.

**Motivo:** São apenas 4 assets (1 neutro + 3 blink), cada piscada dura ~120ms
e ocorre a cada 4-15s. A troca de `Image.asset` é instantânea com precache.
Overlay adicionaria complexidade desnecessária.

### D3 — Duração da piscada

**Decisão:** 120ms.

**Motivo:** Uma piscada humana típica dura 100-150ms. 120ms é o ponto médio:
rápida o suficiente para parecer natural, lenta o suficiente para ser percebida
(especialmente por crianças com processamento visual mais lento). Se durasse
menos que 80ms poderia passar despercebida; se mais que 200ms, pareceria
"sonolenta" em vez de "piscando".

### D4 — Intervalo entre piscadas

**Decisão:** Mínimo 4s, máximo 15s, distribuição uniforme via
`Random().nextInt()`.

**Motivo:** A taxa de piscadas humana em repouso é ~12/min (5s de intervalo
médio), mas varia muito. 4s evita piscadas em rajada; 15s é o limite superior
para não parecer que o mascote "travou". A distribuição uniforme sem
exponencial é proposital: mantém a imprevisibilidade natural sem agrupar
piscadas.

### D5 — Resposta ao toque

**Decisão:** Ao tocar:
1. Cancela o timer do ciclo atual
2. Escolhe um tipo aleatório de piscada
3. Exibe o asset de piscada por 120ms
4. Retorna ao neutro
5. Agenda o próximo ciclo a partir desse momento (+ 4 a 15s)

**Toques consecutivos rápidos:** Se o usuário tocar enquanto uma piscada está
em curso (dentro dos 120ms), o timer de retorno ao neutro é reiniciado: o Balô
mostra um NOVO tipo de piscada (nova escolha aleatória) e o cronômetro de 120ms
recomeça. Isso evita enfileiramento e mantém a fluidez.

**Justificativa:** Crianças autistas podem tocar repetidamente por interesse
sensorial na resposta. O comportamento deve ser previsível e imediato: cada
toque → uma resposta, sem acumular.

### D6 — Asset neutro

**Decisão:** Usar `assets/logo.png` como o estado padrão (neutro) entre as
piscadas.

**Motivo:** É o mesmo asset que o `Balowidget` exibe. Mantém consistência
visual com o resto do app.

### D7 — Balanço inicial + piscada

**Decisão:** O `BaloMascote` executa o balanço inicial (wave) com um
`AnimationController` interno. Um listener de status detecta quando a animação
completa e, só então, inicia o primeiro timer de piscada. Se a animação for
desativada (`disableAnimations`), o ciclo de piscadas nunca inicia.

**Fluxo:**
1. `initState` → precache imagens, inicia wave controller
2. Wave completa (`AnimationStatus.completed`) → `_startBlinkCycle()`
3. `_startBlinkCycle()` → agenda timer com intervalo aleatório
4. Timer dispara → `_doBlink()` → mostra asset blink por 120ms → volta ao neutro → agenda próximo ciclo
5. Toque → `_onTap()` → mesmo fluxo do `_doBlink()` mas imediato + reagenda

### D8 — Pré-carregamento (precache)

**Decisão:** Chamar `precacheImage()` no `initState` para cada um dos 3 assets
de piscada.

**Motivo:** Evita o "flicker" ou atraso na primeira troca de asset, que
ocorreria se a imagem fosse carregada sob demanda no momento da piscada.

### D9 — Acessibilidade

**Decisão:** Quando `MediaQuery.disableAnimations` ou
`MediaQuery.accessibleNavigation` for true:
- O balanço inicial NÃO ocorre (neutral asset desde o início)
- O ciclo de piscadas NUNCA inicia
- O toque no Balô NÃO produz piscada
- O mascote permanece estático e neutro

Isso estende a regra existente do `Balowidget` para o novo widget.

## API do BaloMascote

```dart
class BaloMascote extends StatefulWidget {
  final double size;
  final VoidCallback? onTap;  // callback adicional (além da piscada)
}
```

- `size`: tamanho do mascote (padrão 120)
- `onTap`: callback opcional disparado após a piscada de resposta ao toque

## Risks / Trade-offs

- **[Risk] Piscada imperceptível em telas muito pequenas:** mitigado pelo
  tamanho generoso do Balô na HomeScreen (120dp) + assets em alta resolução.
- **[Risk] Criança com epilepsia fotossensível:** a piscada é uma troca de
  asset estático, não um flash/transição animada, e dura 120ms. A redução de
  movimento desativa completamente. Risco mínimo.
- **[Risk] Asset de piscada não carregado a tempo:** mitigado pelo precache
  no `initState`. Se o precache falhar (asset ausente), o `Image.asset` usa o
  placeholder padrão do Flutter (caixa cinza) — aceitável para um asset que
  só aparece 120ms.
- **[Trade-off] Widget separado vs. parâmetro no BaloWidget:** escolhemos
  separado para manter cada widget com uma responsabilidade clara.
