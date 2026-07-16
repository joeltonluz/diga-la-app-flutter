## Why

O Modo Aprender ainda é um placeholder ("em breve"). Sem ele, o app só tem o Modo Conversar (expressão) e nenhuma ferramenta de aprendizado de vocabulário. Crianças autistas se beneficiam de explorar palavras organizadas por temas (animais, frutas, etc.) com repetição auditiva e visual, o que este modo entrega.

## What Changes

- Criar modelo `Category` com id, nome, ícone e lista de itens (`Card` bilíngue)
- Criar uma lista **fixa (hardcoded)** de 5 categorias cada uma com 5 itens bilíngues (PT+EN)
  - Animais, Frutas, Transportes, Partes do Corpo, Cores
- Substituir o placeholder da `LearnScreen` por uma grade de categorias
- Ao tocar numa categoria, navegar para uma tela de itens que reusa `CardTile` existente
- Ao tocar num item, falar usando o `LanguageService` central (sem lógica de idioma nova)
- Prover botão de voltar claro da tela de itens para a lista de categorias

## Capabilities

### New Capabilities
- `learn-mode`: Navegação e exibição do Modo Aprender com categorias fixas e itens bilíngues falados pelo serviço central de idioma

### Modified Capabilities
- `card-grid`: A tela de itens por categoria reusa o `CardTile` — mas o comportamento já está coberto pela spec existente (tocar fala). Nenhuma mudança de requisito.

## Impact

- Cria `lib/models/category.dart`
- Cria `lib/data/sample_categories.dart` (dados fixos)
- Cria `lib/screens/category_grid_screen.dart` (itens de uma categoria)
- Modifica `lib/screens/learn_screen.dart` (de placeholder para grade de categorias)
- Reusa `lib/widgets/card_tile.dart`, `LanguageService`, modelo `Card` bilíngue — nenhuma alteração nesses arquivos
- Nenhuma nova dependência
