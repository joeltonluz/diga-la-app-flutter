## 1. Limpeza do boilerplate Flutter

- [x] 1.1 Remover todo o código de exemplo do `lib/main.dart`: classe `MyHomePage`, `_MyHomePageState`, contador, FloatingActionButton, comentários tutoriais, texto "You have pushed the button" e o title "Flutter Demo Home Page"
- [x] 1.2 Substituir o conteúdo de `lib/main.dart` por uma entrada limpa que apenas chama `runApp` com um `MaterialApp` simples
- [x] 1.3 Remover o teste de exemplo `test/widget_test.dart` (teste do contador) e criar um teste mínimo que valida que a tela inicial renderiza sem erros
- [x] 1.4 Limpar comentários boilerplate do `pubspec.yaml` (descrição, seção de versionamento, comentários de assets/fonts)
- [x] 1.5 Verificar com `flutter analyze` que não há warnings ou erros após a limpeza

## 2. Estrutura de pastas

- [x] 2.1 Criar diretórios em `lib/`: `screens/`, `widgets/`, `theme/`, `services/`, `providers/`
- [x] 2.2 Criar `lib/app.dart` extraindo o widget `MaterialApp` de `main.dart`

## 3. Dependências no pubspec.yaml

- [x] 3.1 Adicionar `flutter_tts` às dependências
- [x] 3.2 Adicionar `flutter_riverpod` às dependências
- [x] 3.3 Adicionar `hive` e `hive_flutter` às dependências
- [x] 3.4 Adicionar `flutter_launcher_icons` às dev_dependencies
- [x] 3.5 Adicionar seção `flutter_launcher_icons` ao `pubspec.yaml` apontando `image_path: "assets/logo.png"`
- [x] 3.6 Rodar `flutter pub get` para instalar as dependências
- [x] 3.7 Remover `cupertino_icons` da seção de dependências (não será usado)

## 4. Tema inclusivo

- [x] 4.1 Criar `lib/theme/app_theme.dart` com uma classe `AppTheme` contendo o tema claro padrão: paleta suave (azul acinzentado, creme, rosa suave), touch targets mínimos de 56dp, font-size mínimo 18dp corpo / 24dp títulos
- [x] 4.2 Estruturar a classe com construtor/static method para o tema regular e deixar preparada a adição de `AppTheme.highContrast()` no futuro
- [x] 4.3 Aplicar `AppTheme.regular()` como `theme` do `MaterialApp` em `lib/app.dart`

## 5. Navegação e telas

- [x] 5.1 Criar `lib/screens/home_screen.dart` com o logo "Diga Lá" (inicialmente texto estilizado, já que o PNG será adicionado depois), dois botões grandes "Conversar" e "Aprender"
- [x] 5.2 Criar `lib/screens/converse_screen.dart` como tela placeholder com título "Modo Conversar" e botão de voltar
- [x] 5.3 Criar `lib/screens/learn_screen.dart` como tela placeholder com título "Modo Aprender" e botão de voltar
- [x] 5.4 Configurar navegação no `MaterialApp`: home apontando para `HomeScreen`, rotas nomeadas para Converse e Learn

## 6. Branding "Diga Lá"

- [x] 6.1 Colocar o arquivo `assets/logo.png` no diretório `assets/`
- [x] 6.2 Adicionar `assets/` à seção `flutter > assets` no `pubspec.yaml`
- [x] 6.3 Usar `Image.asset('assets/logo.png')` no lugar do texto do logo na `HomeScreen`
- [x] 6.4 Alterar `android:label` no `AndroidManifest.xml` de `"diga_la_app"` para `"Diga Lá"`
- [x] 6.5 Rodar `dart run flutter_launcher_icons` para gerar os ícones do app
- [x] 6.6 Verificar no log se a geração de ícones concluiu sem erros; se houver warning sobre foreground adaptativo, registrar no design.md como pendência

## 7. Serviço TTS e botão temporário

- [x] 7.1 Criar `lib/services/tts_service.dart` com classe que encapsula `FlutterTts`, com método `speak(String text)` e `setLanguage(String lang)`
- [x] 7.2 Configurar idioma padrão como `pt-BR` no construtor do serviço
- [x] 7.3 Criar `lib/providers/tts_provider.dart` expondo o `TtsService` como um Riverpod provider
- [x] 7.4 Criar `lib/widgets/temp_tts_button.dart` com um botão que chama `speak("Olá")` ao ser pressionado, com comentário marcando como temporário para remoção futura
- [x] 7.5 Adicionar o `TempTtsButton` na `HomeScreen` abaixo dos botões de navegação
- [x] 7.6 Verificar com `flutter analyze` que não há erros

## 8. Smoke test e verificação final

- [x] 8.1 Criar `test/app_test.dart` com um smoke test que instancia o `App` widget e verifica se a tela inicial renderiza sem erros
- [x] 8.2 Rodar `flutter test` e confirmar que todos os testes passam
- [x] 8.3 Rodar `flutter analyze` e confirmar 0 warnings/errors
- [ ] 8.4 Fazer build de debug (`flutter build apk --debug`) e confirmar que compila
