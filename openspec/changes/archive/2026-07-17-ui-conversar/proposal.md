## Why

A tela Conversar atual tem um layout funcional mas não corresponde ao mockup refinado: o botão Falar é apenas um ícone circular (sem rótulo "Falar"), o AppBar não tem botão voltar, a lista de cartões não está alinhada ao mockup (faltam ajuda, parar, obrigado, comer; sobram comida, dormir, casa, acabou), e não há distinção visual clara entre APAGAR (remove o último) e Limpar (esvazia tudo). Esta change refina a tela para bater com o mockup no visual e na função.

## What Changes

- **AppBar**: adicionar botão voltar circular à esquerda; título "Conversar" centralizado (antes era "Modo Conversar").
- **Botão Falar**: substituir ícone circular por ElevatedButton com texto "Falar", azul preenchido com texto branco.
- **APAGAR**: botão com ícone backspace que remove o último cartão. Já existe em código, mas agora fica explicitamente separado de Limpar no layout do mockup.
- **Barra de frase**: layout estável (não empurra grade ao adicionar/remover cartões).
- **Grade de cartões**: 3 colunas (já implementado), cantos arredondados e sombra via tokens.
- **Cartões de amostra**: alinhar lista para: eu, quero, comer, água, sim, não, mais, ajuda, banheiro, brincar, parar, obrigado. Novos: comer, ajuda, parar, obrigado. Removidos: comida, dormir, casa, acabou, nao_lig, por_favor.

## Capabilities

### New Capabilities
- `ui-conversar`: refinamento visual da tela Conversar com AppBar, botão Falar textual, distinção apagar/limpar, grade 3 colunas com tokens do tema, e lista de cartões alinhada ao mockup.

### Modified Capabilities
- Nenhuma — os comportamentos (falar, limpar, apagar) já estão especificados em `sentence-bar` e `card-grid`. Esta change adiciona apenas requisitos visuais e de lista de cartões.

## Impact

- `lib/screens/converse_screen.dart`: reformular AppBar (voltar, título), substituir ícone Falar por ElevatedButton, ajustar layout.
- `lib/data/sample_cards.dart`: substituir lista por 12 cartões do mockup.
- `lib/widgets/sentence_bar.dart`: verificar se precisa de ajustes para layout estável.
- `test/screens/converse_screen_test.dart`: novos testes TDD para apagar, limpar, Falar, grid.
- Nenhuma dependência nova. Nenhuma mudança em modelos, providers, ou outras telas.
