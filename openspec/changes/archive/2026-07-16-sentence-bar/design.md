## Context

O Modo Conversar (`ConverseScreen`) exibe uma grade de 2 colunas com `CardTile` e, ao toque, fala a palavra via `LanguageService.speak()`. O `Card` já tem `labelPt`/`labelEn` e `emoji`. O `LanguageService` já fala em PT, EN ou PT+EN. O Modo Aprender (`LearnScreen`) também usa grade + `CardTile` + `LanguageService.speak()`, mas com navegação por categorias.

A mudança é apenas no ConverseScreen: em vez de falar ao toque, o toque adiciona à barra; a fala fica no botão "Falar". A barra de frase é um novo componente visual, mas reusa o `CardTile` para exibir cada cartão.

## Goals / Non-Goals

**Goals:**
- Barra horizontal no topo do ConverseScreen mostrando cartões selecionados
- Tocar cartão na grade → adiciona à barra (não fala)
- Botão Falar → percorre a barra e fala cada cartão via `LanguageService.speak()` em sequência
- Botão Limpar → esvazia a barra inteira
- Botão Apagar último → remove o último cartão adicionado
- Adicionar 5 palavras de ligação à lista fixa (`sample_cards.dart`)
- Grade e `CardTile` reusados sem alteração

**Non-Goals:**
- Não altera o Modo Aprender (continua falando item por item ao toque)
- Não altera `CardTile`, `LanguageService`, `Card` nem `TtsService`
- Não salva frases em banco/histórico
- Não faz predição de próxima palavra ou conjugação
- Não tem animações complexas

## Decisions

### Estado da frase: StatefulWidget vs. Riverpod
**Decisão:** Estado local com `StatefulWidget` (lista de `Card` no `_ConverseScreenState`).
**Motivo:** O estado da barra só interessa a esta tela. Não precisa ser global nem persistido. Riverpod adicionaria complexidade sem benefício aqui. Se no futuro a barra precisar ser compartilhada com outras telas, migra-se para Riverpod.

### Tocar cartão: adicionar à barra vs. menu contextual
**Decisão:** Toque simples adiciona à barra.
**Motivo:** Ação previsível e única — a criança toca e o cartão aparece na barra. Menu com opções (ex.: "falar agora" vs. "adicionar") adiciona complexidade cognitiva desnecessária para uma criança CAA.

### Layout da barra: horizontal scroll vs. wrap vs. row fixa
**Decisão:** `SingleChildScrollView` horizontal com `Row`.
**Motivo:** A barra precisa acomodar N cartões lado a lado sem quebrar para a linha debaixo (evitar "pulo" no layout). O scroll horizontal mantém a grade estável — a altura da barra é fixa. O `ClipRRect` suaviza a borda.

### Remover cartão da barra: botão apagar último vs. toque no cartão
**Decisão:** Botão de apagar último (`IconButton` com `Icons.backspace`) ao lado do "Falar" e "Limpar".
**Motivo:** Tocar no cartão dentro da barra seria inconsistente com o toque na grade (que adiciona). Botão separado é mais previsível. Crianças autistas se beneficiam de ações explícitas e rotuladas.

### Falar frase: speak sequencial vs. texto concatenado
**Decisão:** Chamar `LanguageService.speak(card)` para cada cartão em sequência (com `await`).
**Motivo:** O `LanguageService` já resolve o locale e a ordem PT/PT+EN/EN internamente. Se a frase é "eu quero água", o app fala 3 vezes seguidas, cada uma respeitando o modo de idioma. Concatenar texto burlaria o controle de locale do serviço.

### Tamanho da barra: fixo (altura ~100dp)
**Decisão:** Altura fixa de aproximadamente 100dp (80dp para os cartões + padding).
**Motivo:** Evita "pulo" no layout ao adicionar/remover cartões. A grade abaixo permanece estável.

### Palavras de ligação: adicionar à lista fixa existente
**Decisão:** Inserir no array `sampleCards` no final, mantendo os cartões originais intactos.
**Motivo:** São cartões como qualquer outro no modelo bilíngue. O ConverseScreen já itera sobre `sampleCards`.

## Risks / Trade-offs

- **Barra ocupa espaço vertical:** A grade de cartões fica menor (a tela tem que acomodar barra + grade). Mitigação: a altura fixa da barra (~100dp) é previsível e a grade rola abaixo dela.
- **Fala sequencial semântica:** Falar "eu quero água" cartão por cartão pode soar robotizado, mas é fiel ao conteúdo selecionado. Melhoria futura: concatenar texto e passar ao LanguageService de uma vez (exige suporte `speak(String)` no serviço).
- **Scroll horizontal na barra:** Se a criança adicionar muitos cartões, a barra rola horizontalmente. A descoberta dessa funcionalidade pode não ser óbvia. Mitigação: exibir sempre os últimos cartões adicionados com `scrollController.animateTo(end)`.
