## 1. Estender modelo Card

- [x] 1.1 Substituir o campo `label` por `labelPt` (String) e adicionar `labelEn` (String) no modelo `lib/models/card.dart`
- [x] 1.2 Adicionar getter `label` que retorna `labelPt` para retrocompatibilidade
- [x] 1.3 `CardTile` compila sem erros (usa `card.label` → getter → `labelPt`)
- [x] 1.4 `ConverseScreen` compila sem erros (usa `tts.speak(card.label)` → getter → `labelPt`)

## 2. Atualizar lista fixa de cartões

- [x] 2.1 Adicionar `labelEn` a cada cartão em `lib/data/sample_cards.dart`
- [x] 2.2 `labelPt` mantido inalterado para todos os cartões

## 3. Verificação

- [x] 3.1 Rodar `flutter analyze` — 0 issues
- [x] 3.2 Rodar `flutter test` — all passed
- [x]  3.3 Confirmar visualmente que o Modo Conversar fala PT-BR ao tocar cartões (requer dispositivo/emulador)
