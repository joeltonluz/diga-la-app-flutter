## 0. Preparação e testes (TDD)

- [ ] 0.1 Registrar `assets/feelings/` no `pubspec.yaml`
- [ ] 0.2 Criar `test/widgets/balo_mascote_test.dart` com estrutura inicial
- [ ] 0.3 **TESTE (RED):** BaloMascote renderiza asset neutro (`assets/logo.png`)
- [ ] 0.4 **TESTE (RED):** BaloMascote aceita tamanho customizado
- [ ] 0.5 **TESTE (RED):** Ao disparar piscada (controlada via método exposto),
       o asset muda para um dos três blink e retorna ao neutro após 120ms
- [ ] 0.6 **TESTE (RED):** Toque no Balô dispara piscada imediata
- [ ] 0.7 **TESTE (RED):** Toques consecutivos não enfileiram (reinicia a piscada)
- [ ] 0.8 **TESTE (RED):** Com `disableAnimations`, nenhuma piscada ocorre
       (inclusive ao toque)
- [ ] 0.9 **TESTE (RED):** Timers cancelados no dispose
- [ ] 0.10 **TESTE (RED):** Balanço inicial termina antes da primeira piscada

## 1. Criar widget BaloMascote

- [ ] 1.1 Criar `lib/widgets/balo_mascote.dart` com estrutura stateful,
       construtor com `size` (padrão 120) e `onTap` opcional
- [ ] 1.2 Implementar `initState`: precache dos 3 assets de piscada,
       iniciar `AnimationController` do balanço (wave)
- [ ] 1.3 Implementar o balanço inicial: TweenSequence idêntico ao
       `BaloAnimation.wave` do `Balowidget` (rotação -0.5° a +0.5°, 3,2s)
- [ ] 1.4 Adicionar listener no wave controller: ao completar, chamar
       `_startBlinkCycle()`
- [ ] 1.5 Implementar `_startBlinkCycle()`: agendar `Timer` com intervalo
       aleatório entre 4 e 15s usando `Random().nextInt()`
- [ ] 1.6 Implementar `_doBlink()`: escolher tipo aleatório (both, left,
       right), exibir asset por 120ms via `Future.delayed`, retornar ao neutro
- [ ] 1.7 Após retornar ao neutro, chamar `_startBlinkCycle()` novamente
- [ ] 1.8 Implementar `_onTap()`: cancelar timer atual, disparar piscada
       imediata (escolha aleatória), reagendar próximo ciclo
- [ ] 1.9 Tratar toques consecutivos: cancelar timer de retorno ao neutro
       se houver, mostrar nova piscada, reiniciar timer de 120ms
- [ ] 1.10 Implementar `dispose`: cancelar `_blinkTimer`, `_returnTimer` e
       `_waveController?.dispose()`
- [ ] 1.11 Respeitar `MediaQuery.disableAnimations`: pular wave e blink,
       `onTap` não pisca (apenas chama `onTap` se fornecido)
- [ ] 1.12 Expor `currentAsset` (getter público no State) para testes
- [ ] 1.13 Envolver em `GestureDetector` para capturar toques (área mínima 44x44)

## 2. Integrar na HomeScreen

- [ ] 2.1 Substituir `BaloWidget(animation: BaloAnimation.wave)` na HomeScreen
       por `BaloMascote()`, mantendo layout e posicionamento
- [ ] 2.2 Remover import desnecessário de `balo_widget.dart` da HomeScreen
       (se `BaloWidget` não for mais usado lá)
- [ ] 2.3 Verificar que os assets blink aparecem corretamente no emulador

## 3. Verificar testes e build

- [ ] 3.1 `flutter test` — todos os testes passam (novos + existentes)
- [ ] 3.2 `flutter analyze` — sem warnings ou erros
- [ ] 3.3 Revisar manualmente: piscada visível, toque responsivo, sem vazamento
