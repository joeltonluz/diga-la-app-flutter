## 1. Modelo de dados e lista fixa

- [x] 1.1 Criar `lib/models/card.dart` com a classe `Card` contendo `id` (String), `label` (String), `emoji` (String)
- [x] 1.2 Criar `lib/data/sample_cards.dart` com a lista fixa de 10 cartões: água (💧), comida (🍽️), banheiro (🚽), dormir (🛏️), brincar (🧸), casa (🏠), sim (👍), não (👎), quero (🙋), acabou (✅)

## 2. Widget CardTile

- [x] 2.1 Criar `lib/widgets/card_tile.dart` como `StatelessWidget` que recebe um `Card` e um callback `onTap`
- [x] 2.2 O `CardTile` deve exibir o emoji (tamanho mínimo 40dp) centralizado acima do label
- [x] 2.3 O `CardTile` deve ter tamanho mínimo de 80x80 dp com fundo claro, bordas arredondadas e sombra suave
- [x] 2.4 O `CardTile` deve usar `InkWell` com splash suave para feedback visual ao toque (sem animações abruptas)

## 3. Grade na tela Conversar

- [x] 3.1 Substituir o conteúdo de `lib/screens/converse_screen.dart` para renderizar os cartões em um `GridView.count` com `crossAxisCount: 2`
- [x] 3.2 Integrar o TTS: ao tocar um `CardTile`, chamar `ref.read(ttsServiceProvider).speak(card.label)`
- [x] 3.3 Garantir que o padding e espaçamento da grade sigam o tema inclusivo (16dp entre cartões)

## 4. Remover botão TTS temporário

- [x] 4.1 Remover o arquivo `lib/widgets/temp_tts_button.dart`
- [x] 4.2 Remover a importação e uso do `TempTtsButton` em `lib/screens/home_screen.dart`
- [x] 4.3 O provider `ttsServiceProvider` permanece pois é usado pela `ConverseScreen`

## 5. Verificação

- [x] 5.1 Rodar `flutter analyze` e confirmar 0 warnings/errors
- [x] 5.2 Rodar `flutter test` e confirmar que todos os testes passam
- [x] 5.3 Verificar visualmente: navegar para Conversar, tocar cartões e ouvir o TTS
