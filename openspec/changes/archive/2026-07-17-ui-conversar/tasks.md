## 1. Testes (TDD — escrever primeiro, devem falhar)

- [x] 1.1 Criar `test/screens/converse_screen_test.dart` com teste que apagar remove o último cartão da frase (adicionar 2, apagar 1, resta 1)
- [x] 1.2 Adicionar teste que apagar com frase vazia não lança erro (não quebra)
- [x] 1.3 Adicionar teste que limpar esvazia a frase inteira
- [x] 1.4 Adicionar teste que a grade renderiza cartões do mockup
- [x] 1.5 Adicionar teste que o botão Falar é um ElevatedButton com texto "Falar"
- [x] 1.6 Rodar testes e confirmar que FALHAM

## 2. Atualizar lista de cartões

- [x] 2.1 Substituir `lib/data/sample_cards.dart` pelos 12 cartões do mockup (eu, quero, comer, água, sim, não, mais, ajuda, banheiro, brincar, parar, obrigado)

## 3. Refatorar AppBar da ConverseScreen

- [x] 3.1 Trocar título de "Modo Conversar" para "Conversar" com `centerTitle: true`
- [x] 3.2 Adicionar `leading: IconButton` com seta voltar (`Icons.arrow_back_rounded`) que faz `Navigator.pop(context)`

## 4. Substituir botão Falar

- [x] 4.1 Remover `GestureDetector` + `AnimatedContainer` circular do play
- [x] 4.2 Adicionar `ElevatedButton.icon` com `Icons.play_arrow_rounded` + texto "Falar"
- [x] 4.3 `onPressed: hasCards ? _speakSentence : null` (desabilitado quando vazio)

## 5. Ajustar layout da linha de ações

- [x] 5.1 Reorganizar Row com APAGAR (_removeLast) à esquerda, Falar (ElevatedButton) centralizado, Limpar (_clearSentence) à direita
- [x] 5.2 Ajustar alturas e padding para consistência visual

## 6. Validar

- [x] 6.1 Rodar `flutter test` completo — todos os testes passam
- [x] 6.2 Rodar `flutter analyze` — sem warnings ou erros
- [x] 6.3 Rodar `flutter run` para conferência visual contra mockup
