## 1. Modelo de Categoria

- [x] 1.1 Criar `lib/models/category.dart` com classe `Category` contendo `id`, `name`, `icon` (emoji String) e `items` (`List<Card>`)

## 2. Dados fixos das categorias

- [x] 2.1 Criar `lib/data/sample_categories.dart` com as 5 categorias e seus 5 itens cada:
  - Animais (🐾): cachorro/dog, gato/cat, pássaro/bird, peixe/fish, cavalo/horse
  - Frutas (🍎): maçã/apple, banana/banana, laranja/orange, uva/grape, morango/strawberry
  - Transportes (🚗): carro/car, ônibus/bus, avião/airplane, bicicleta/bicycle, barco/boat
  - Partes do corpo (🖐️): cabeça/head, mão/hand, pé/foot, olho/eye, boca/mouth
  - Cores (🎨): vermelho/red, azul/blue, amarelo/yellow, verde/green

## 3. Tela de itens por categoria

- [x] 3.1 Criar `lib/screens/category_grid_screen.dart`:
  - Recebe uma `Category` e um `LanguageService`
  - Exibe os itens em grid de 2 colunas usando `CardTile` + `LanguageService.speak(card)` ao toque
  - AppBar com título = nome da categoria e botão de voltar automático
  - Padding e espaçamento idênticos ao `ConverseScreen` (16px)

## 4. Substituir placeholder do Modo Aprender

- [x] 4.1 Em `lib/screens/learn_screen.dart`, substituir placeholder por:
  - Grid de categorias 2 colunas
  - Cada tile: emoji grande (40px) + nome da categoria abaixo
  - Ao tocar: navega para `CategoryGridScreen` via `Navigator.push`
  - Obter `LanguageService` do provider Riverpod para passar à tela de itens
  - Manter AppBar com título "Modo Aprender"

## 5. Verificação

- [x] 5.1 Rodar `flutter analyze` e confirmar 0 warnings/errors
- [x] 5.2 Rodar `flutter test` e confirmar que todos os testes passam
- [x] 5.3 Verificar manualmente: navegar Home → Aprender → ver 5 categorias
- [x] 5.4 Verificar manualmente: tocar numa categoria → ver 5 itens → tocar item → ouvir fala no idioma configurado
- [x] 5.5 Verificar manualmente: botão de voltar retorna à lista de categorias
