## Why

A tela Aprender atual tem um layout funcional mas não corresponde aos mockups refinados: o título é "Modo Aprender" (sem botão voltar), a grade de categorias ajusta colunas conforme orientação, e a grade de itens também muda de colunas. Os mockups definem layouts fixos (categorias sempre 2 colunas, itens sempre 3 colunas) com header padronizado (voltar circular + título centralizado). Esta change refina as duas telas do modo Aprender para bater com os mockups.

## What Changes

- **LearnScreen (categorias)**: AppBar com botão voltar circular + título "Aprender" centralizado (antes "Modo Aprender"). Grade sempre 2 colunas (não muda em landscape). Cards de categoria maiores, com emoji centralizado e nome usando estilo `cardLabel`/`titleLarge`.
- **CategoryGridScreen (itens)**: AppBar com botão voltar circular + nome da categoria. Grade sempre 3 colunas (não muda em landscape). Reusa `CardTile` compartilhado.
- **Consistência**: mesmo padrão de botão voltar circular das outras telas (ConverseScreen, HomeScreen). Tokens do tema já aplicados (radii.card, surfaceCard, shadows.card).

## Capabilities

### New Capabilities
- `ui-aprender`: refinamento visual das telas do modo Aprender (categorias e itens) com AppBar padronizado, grades de colunas fixas, e cards consumindo tokens do tema.

### Modified Capabilities
- Nenhuma — os comportamentos (navegação, fala, grid de categorias/itens) já estão especificados em `learn-mode`. Esta change adiciona apenas requisitos visuais.

## Impact

- `lib/screens/learn_screen.dart`: AppBar com voltar + "Aprender", grade fixa 2 colunas, card de categoria com `cardLabel`.
- `lib/screens/category_grid_screen.dart`: AppBar com voltar, grade fixa 3 colunas.
- `test/screens/learn_screen_test.dart`: novos testes TDD (grade de categorias, toque abre itens).
- `test/screens/category_grid_screen_test.dart`: novos testes TDD (itens renderizam, toque fala, voltar).
- Nenhuma mudança em modelos, providers, dados, ou outras telas.
