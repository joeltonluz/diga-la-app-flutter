## 1. Palavras de ligação

- [x] 1.1 Adicionar 5 cartões de ligação ao final de `lib/data/sample_cards.dart`: eu/I, quero/want, não/not, mais/more, por favor/please

## 2. Widget SentenceBar

- [x] 2.1 Criar `lib/widgets/sentence_bar.dart` com `SentenceBar` widget:
  - Recebe `List<Card>` como parâmetro
  - Exibe os cartões em uma `Row` dentro de `SingleChildScrollView` horizontal
  - Cada cartão mostra emoji + label (reusa estilo visual consistente)
  - Altura fixa (~80dp para os cartões + padding de 16dp vertical)

## 3. Botões de ação da barra

- [x] 3.1 Adicionar ao ConverseScreen uma linha de botões abaixo da `SentenceBar`:
  - Botão **Falar**: ícone de play/speaker, chama `LanguageService.speak()` para cada card na sequência
  - Botão **Limpar**: ícone de lixeira/delete, esvazia a lista
  - Botão **Apagar último**: ícone de backspace/undo, remove o último item
  - Botões com alvo de toque mínimo 48x48dp

## 4. Integrar no ConverseScreen

- [x] 4.1 Converter `ConverseScreen` de `ConsumerWidget` para `ConsumerStatefulWidget` para gerenciar estado local da lista de cards na barra
- [x] 4.2 Adicionar `List<Card> _sentenceCards` como estado
- [x] 4.3 Substituir `onTap: () => languageService.speak(card)` por `onTap: () => _sentenceCards.add(card); setState(() {})`
- [x] 4.4 Inserir `SentenceBar` e a linha de botões no layout:
  - Barra no topo (acima da grade)
  - Botões abaixo da barra
  - Grade abaixo dos botões, ocupando o restante da tela em um `Expanded`
  - Tudo dentro de uma `Column`

## 5. Verificação

- [x] 5.1 Rodar `flutter analyze` e confirmar 0 warnings/errors
- [x] 5.2 Rodar `flutter test` e confirmar que todos os testes passam
- [x] 5.3 Verificar manualmente: ConverseScreen mostra barra vazia no topo
- [x] 5.4 Verificar manualmente: tocar cartão adiciona à barra, não fala
- [x] 5.5 Verificar manualmente: Falar fala todos os cartões em sequência no idioma configurado
- [x] 5.6 Verificar manualmente: Limpar e Apagar último funcionam
- [x] 5.7 Verificar manualmente: Modo Aprender continua falando ao toque (sem barra)
