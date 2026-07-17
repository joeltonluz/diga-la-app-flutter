## 1. Testes da LearnScreen (TDD — escrever primeiro, devem falhar)

- [x] 1.1 Criar `test/screens/learn_screen_test.dart` com teste que a grade contém as 5 categorias esperadas
- [x] 1.2 Adicionar teste que tocar numa categoria navega para CategoryGridScreen
- [x] 1.3 Adicionar teste que o título do AppBar é "Aprender"
- [x] 1.4 Adicionar teste que a GridView tem crossAxisCount igual a 2
- [x] 1.5 Rodar testes e confirmar que FALHAM (3/8 falham: AppBar, crossAxisCount landscape, speak call)

## 2. Testes da CategoryGridScreen (TDD)

- [x] 2.1 Criar `test/screens/category_grid_screen_test.dart` com teste que os itens da categoria renderizam com CardTile
- [x] 2.2 Adicionar teste que tocar num item chama LanguageService.speak
- [x] 2.3 Adicionar teste que o AppBar tem botão voltar e nome da categoria
- [x] 2.4 Adicionar teste que a GridView tem crossAxisCount igual a 3
- [x] 2.5 Rodar testes e confirmar que FALHAM

## 3. Refatorar LearnScreen

- [x] 3.1 AppBar: adicionar `leading: IconButton` com `Icons.arrow_back_rounded` + `Navigator.pop(context)`; título "Aprender" com `centerTitle: true`
- [x] 3.2 Grade: fixar `crossAxisCount: 2` (remover lógica landscape)
- [x] 3.3 Card de categoria: trocar estilo do nome para `DesignTokens.textStyles.cardLabel`

## 4. Refatorar CategoryGridScreen

- [x] 4.1 AppBar: adicionar `leading: IconButton` com `Icons.arrow_back_rounded` + `Navigator.pop(context)`; `centerTitle: true`
- [x] 4.2 Grade: fixar `crossAxisCount: 3` (remover lógica landscape)

## 5. Validar

- [x] 5.1 Rodar `flutter test` completo — 72/72 passam
- [x] 5.2 Rodar `flutter analyze` — sem warnings ou erros
- [x] 5.3 Rodar `flutter run` para conferência visual contra mockup
