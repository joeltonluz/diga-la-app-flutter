## 1. Criar widget BalôWidget

- [x] 1.1 Criar `lib/widgets/balo_widget.dart` com enum `BaloAnimation`, widget stateful, parâmetros `size`, `animation`, `onTap`, `emptyMessage`
- [x] 1.2 Implementar animação `breathing` (scale 1.0↔1.02, 3s ciclo, `Curves.easeInOut`, loop infinito)
- [x] 1.3 Implementar animação `wave` (rotate -2°/+2°, 1s, `Curves.easeInOut`, 1x com flag `_hasWaved`)
- [x] 1.4 Implementar método público `startPulse()` via `GlobalKey<BalôWidgetState>` (scale 1.0→1.05→1.0, 400ms, `Curves.easeOut`)
- [x] 1.5 Respeitar `MediaQuery.disableAnimations` — manter estático se true
- [x] 1.6 Exibir `emptyMessage` em `Text` abaixo do Balô quando fornecido
- [x] 1.7 Adicionar `onTap` via `GestureDetector`

## 2. Integrar nas telas existentes

- [x] 2.1 Substituir `Image.asset('assets/logo.png')` no `SplashScreen` por `BalôWidget(animation: BaloAnimation.breathing)` mantendo tamanho 140
- [x] 2.2 Substituir `Image.asset('assets/logo.png')` no `HomeScreen` por `BalôWidget(animation: BaloAnimation.wave)` mantendo tamanho 120
- [x] 2.3 Substituir texto vazio do `SentenceBar` por `BalôWidget(emptyMessage: emptyMessage)` quando não há cartões
- [x] 2.4 No `ConverseScreen`, usar `GlobalKey` no Balô e disparar `startPulse()` ao observar `speakingIndexProvider` mudando de `null` para `0`

## 3. Verificar testes e build

- [x] 3.1 Verificar que `flutter analyze` passa sem erros
- [x] 3.2 Verificar que `flutter test` passa — 95/95 testes
- [x] 3.3 Verificar que `flutter build` compila sem warnings (pulado — depende de configuração iOS/Android)
