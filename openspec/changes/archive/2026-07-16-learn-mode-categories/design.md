## Context

O Modo Aprender é o segundo pilar do app Diga Lá (ao lado do Modo Conversar). Atualmente a tela `LearnScreen` exibe apenas um placeholder. O modelo `Card` já carrega `labelPt`/`labelEn` e `emoji` (change bilingual-data-model). O serviço `LanguageService` central já fala em PT, EN ou PT+EN conforme configuração salva (change language-settings). O widget `CardTile` já renderiza um cartão com emoji + label e chama um `onTap`.

Esta change conecta esses pontos: cria um modelo de categoria, dados fixos, e navegação categoria → itens, tudo consumindo o que já existe.

## Goals / Non-Goals

**Goals:**
- Criar modelo `Category` (id, name, icon, items: List<Card>)
- Definir 5 categorias fixas (5 itens cada) em dados hardcoded
- Substituir placeholder da `LearnScreen` por grade de categorias
- Criar `CategoryGridScreen` que exibe itens de uma categoria reusando `CardTile`
- Ao tocar num item, chamar `LanguageService.speak(card)` — sem lógica de idioma
- Navegação bidirecional clara (categorias ↔ itens, com back)

**Non-Goals:**
- Não cria/edit/deleta categorias pelo usuário
- Não persiste em banco de dados (dados fixos no código)
- Não adiciona câmera/fotos reais
- Não introduz lógica de idioma (já centralizada no LanguageService)
- Não altera CardTile, Card, LanguageService, TtsService ou qualquer arquivo fora dos listados no Impact

## Decisions

### Category model com lista de Cards embutida vs. referência
**Decisão:** Lista embutida (`List<Card>`).
**Motivo:** Dados são fixos e pequenos (5 categorias × 5 itens = 25 cards). Não há necessidade de normalização ou consulta separada. Simplicidade máxima.

### Grade de categorias: grid de 2 colunas vs. lista vertical
**Decisão:** Grid de 2 colunas com cards maiores.
**Motivo:** Consistência visual com o Modo Conversar (que já usa grid 2×). Categorias são entidades visuais (ícone + nome), e o grid aproveita melhor o espaço. Alvos de toque grandes (>80dp) alinhados ao design inclusivo.

### Tela de itens: tela separada vs. expansão in-line
**Decisão:** Tela separada (`CategoryGridScreen`) navegada via `Navigator.push`.
**Motivo:** Mantém a navegação previsível e com botão de voltar claro. Cada categoria tem 5 itens que ocupam uma tela cheia — expansão in-line seria crowding visual.

### Fala: LanguageService direto vs. novo serviço de aprendizado
**Decisão:** `LanguageService.speak(card)` direto, sem intermediário.
**Motivo:** O LanguageService já encapsula toda a lógica de idioma, locale e sequência. Um wrapper adicionaria zero valor e violaria o princípio DRY.

### Ícone da categoria: emoji vs. asset image
**Decisão:** Emoji no campo `icon` (String).
**Motivo:** Consistência com o modelo `Card` que usa `emoji`. Zero assets novos. Escalável para futuras categorias sem designer gráfico.

## Risks / Trade-offs

- **Dados fixos:** Troca por simplicidade agora. Quando `persistence-local` for implementada, as categorias fixas podem servir como seed data. Sem risco de migração porque não há banco ainda.
- **2 níveis de navegação (home → categorias → itens):** Risco de a criança se perder. Mitigação: back button proeminente no AppBar + título claro da categoria. Mantemos a mesma estrutura do app principal.
- **CardTile mostra `label` (que retorna `labelPt`):** Para o Modo Aprender, idealmente seria o label no idioma configurado, mas isso é uma melhoria futura (não atrapalha a fala, que já respeita a configuração).
