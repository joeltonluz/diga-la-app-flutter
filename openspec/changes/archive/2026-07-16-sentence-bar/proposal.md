## Why

O Modo Conversar ainda fala uma palavra solta por toque, mas a proposta CAA é a criança **montar frases**. Sem uma barra que encadeie cartões, o app não cumpre seu propósito de dar voz — a criança só consegue dizer uma palavra de cada vez, sem construir significado.

## What Changes

- Adicionar **barra de frase** no topo do Modo Conversar exibindo os cartões selecionados em sequência
- Tocar num cartão da grade **adiciona** à barra (não fala mais direto)
- Botão **Falar**: fala a frase inteira usando `LanguageService` (PT, EN ou PT+EN)
- Botão **Limpar**: esvazia a barra
- Botão **Apagar último**: remove o último cartão da barra
- Adicionar 5 palavras de ligação à lista fixa: eu/I, quero/want, não/not, mais/more, por favor/please
- Grade permanece igual (`CardTile`) — só muda o `onTap` no ConverseScreen; LearnScreen não é afetado

## Capabilities

### New Capabilities
- `sentence-bar`: Barra de frase que encadeia cartões, fala a frase inteira, limpa e remove itens

### Modified Capabilities
- *(Nenhuma — o card-grid spec descreve o componente visual, que não muda; o CardTile continua igual. A mudança é no comportamento do ConverseScreen, não na spec do grid.)*

## Impact

- Cria `lib/widgets/sentence_bar.dart` (widget da barra)
- Cria `lib/widgets/sentence_bar_action.dart` (botões Falar/Limpar/Apagar)
- Modifica `lib/screens/converse_screen.dart` (adiciona barra + muda onTap para add, não speak)
- Modifica `lib/data/sample_cards.dart` (adiciona 5 palavras de ligação)
- Reusa `CardTile`, `LanguageService.speak()`, modelo `Card` bilíngue — sem alterações
- Nenhuma nova dependência
- LearnScreen não é tocado
