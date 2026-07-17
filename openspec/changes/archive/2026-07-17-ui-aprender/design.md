## Context

A LearnScreen e CategoryGridScreen atuais já usam tokens do tema (via fix-screens-theme-usage) e têm a estrutura funcional correta. LearnScreen usa Material+InkWell com DesignTokens para cards de categoria. CategoryGridScreen usa CardTile para itens. O que falta é alinhar o visual aos mockups: AppBar padronizado, grades de colunas fixas, e estilo de texto dos cards de categoria.

## Goals / Non-Goals

**Goals:**
- LearnScreen: AppBar com voltar + "Aprender" centralizado, grade sempre 2 colunas, card de categoria com `cardLabel`/`titleLarge` para nome
- CategoryGridScreen: AppBar com voltar + nome da categoria, grade sempre 3 colunas
- Reuso do CardTile compartilhado nos itens (já implementado)
- Botão voltar circular idêntico ao padrão do ConverseScreen
- Testes: grade de categorias renderiza, toque abre itens, toque em item fala, voltar funciona

**Non-Goals:**
- Mudança no conteúdo das categorias ou itens
- Criação de novos widgets além do necessário
- Mudança no comportamento de fala (LanguageService.speak)
- Outras telas

## Decisions

### 1. AppBar padronizado
Usar `AppBar(leading: IconButton(Icons.arrow_back_rounded, ...), centerTitle: true)` em ambas as telas. LearnScreen: `title: const Text('Aprender')`. CategoryGridScreen: `title: Text(category.name)`.

### 2. Grade de categorias fixa 2 colunas
Remover a lógica `isLandscape ? 3 : 2` e usar `crossAxisCount: 2` sempre. O `childAspectRatio` pode ser ajustado: usar 1.0 em portrait e 1.2 em landscape para melhor aproveitamento.

### 3. Card de categoria com cardLabel
Manter o Material+InkWell+Container atual, mas trocar o estilo do nome de `bodyMedium` com `fontWeight.w500` para `DesignTokens.textStyles.cardLabel` (ou `titleLarge`). O card já usa emoji grande (fontSize: 40) — manter.

### 4. Grade de itens fixa 3 colunas
Remover a lógica `isLandscape ? 3 : 2` e usar `crossAxisCount: 3` sempre. `childAspectRatio: 1.0` em portrait e `1.4` em landscape.

### 5. Testes
- `test/screens/learn_screen_test.dart`: grade contém 5 categorias; tocar numa abre CategoryGridScreen; grid tem 2 colunas; título é "Aprender"
- `test/screens/category_grid_screen_test.dart`: itens renderizam com CardTile; tocar em item chama speak; voltar retorna

## Risks / Trade-offs

- **[Responsividade]** Grades fixas podem deixar espaços vazios em landscape. **Mitigação:** ajustar `childAspectRatio` dinamicamente
- **[Regressão]** Testes existentes que esperam "Modo Aprender" vão falhar. **Mitigação:** ajustar `splash_screen_test.dart` se necessário (ele testa navegação para o Início, não para Aprender)
