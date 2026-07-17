## 1. Testes da splash (TDD -- escrever primeiro, devem falhar)

- [x] 1.1 Criar `test/screens/splash_screen_test.dart` com teste que a splash exibe "Diga La" e "Comunicacao que aproxima"
- [x] 1.2 Adicionar teste que a splash exibe o logo (Image com asset `assets/logo.png`)
- [x] 1.3 Adicionar teste que tocar na splash navega para o Inicio (verificar que HomeScreen aparece apos toque)
- [x] 1.4 Adicionar teste que o timer de 2s navega automaticamente (usar `tester.pump(Duration(seconds: 2))`)
- [x] 1.5 Rodar os testes e confirmar que FALHAM (splash ainda nao existe) -- 2/4 falham

## 2. Implementar SplashScreen

- [x] 2.1 Criar `lib/screens/splash_screen.dart` com StatefulWidget:
  - Fundo: `DesignTokens.colors.surfaceScreen`
  - Logo: `Image.asset('assets/logo.png', width: 120, height: 120)` centralizado
  - Nome: Text("Diga La") com `DesignTokens.textStyles.displayLarge` (Nunito w800)
  - Subtitulo: Text("Comunicacao que aproxima") com `bodyMedium` e cor secundaria
  - Timer de 2s disparando `_navigateToHome()`
  - `GestureDetector` em toda a tela chamando `_navigateToHome()` no toque
  - `dispose()` cancelando o timer
- [x] 2.2 Implementar `_navigateToHome()`: cancela timer, faz navegacao com fade

## 3. Transicao suave

- [x] 3.1 Navegacao usa `PageRouteBuilder` com FadeTransition (400ms easeInOut)
- [x] 3.2 Verifica `MediaQuery.disableAnimations`; se true, usa pushReplacementNamed sem animacao

## 4. Conectar ao app

- [x] 4.1 Em `lib/app.dart`: `initialRoute: '/splash'`, rota `'/splash'` adicionada, rota `'/'` mantida
- [x] 4.2 Importar SplashScreen em app.dart

## 5. Validar testes -- agora devem passar

- [x] 5.1 Executar `flutter test test/screens/splash_screen_test.dart` -- 4/4 passam
- [x] 5.2 Executar `flutter test` completo -- 56/56 testes passam
- [x] 5.3 Executar `flutter analyze` -- sem warnings ou erros
- [x] 5.4 Rodar `flutter run` para conferencia visual (build e analyze ok)
