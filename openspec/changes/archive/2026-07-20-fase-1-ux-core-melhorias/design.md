## Context

O app Diga Lá está implementado com Flutter + Riverpod + SharedPreferences. O ConverseScreen exibe 12 cards fixos (`sample_cards.dart`) em uma grade 3-colunas com barra de frase horizontal. O LearnScreen exibe 13 categorias com 227+ cards totais, mas estes não estão acessíveis no modo Conversar. A sentence bar atual só permite `removeLast()` e `clear()`. Não há feedback visual durante o TTS nem frases salvas. O modo alto contraste é um stub que retorna o tema regular.

O estado da sentença é gerenciado por `SentenceNotifier` (StateNotifier\<List\<PictogramCard\>\>). O TTS é controlado por `LanguageService.speak(card)` que não expõe callbacks de progresso.

## Goals / Non-Goals

**Goals:**
1. Unificar acesso a todos os cartões (incluindo categorias) no ConverseScreen
2. Adicionar reordenação (drag-and-drop) e remoção específica de cartões na sentence bar
3. Destacar visualmente o cartão sendo falado durante o TTS
4. Salvar, listar e reutilizar frases completas
5. Implementar tema de alto contraste funcional

**Non-Goals:**
- Não alterar o comportamento do LearnScreen (continua falando no toque)
- Não adicionar persistência remota ou cloud sync
- Não adicionar autenticação ou login
- Não modificar o modelo de dados PictogramCard ou Category
- Não alterar a navegação geral ou estrutura de rotas

## Decisions

### D1 — Navegação por categorias no ConverseScreen: Chips horizontais roláveis

**Decisão:** Adicionar uma linha horizontal de chips/categoria acima da grade de cards, permitindo à criança navegar entre categorias sem sair da tela.

**Alternativas consideradas:**
- *Bottom sheet com lista de categorias* → mais um nível de navegação, atrito extra
- *Abas (TabBar)* → ocupam espaço vertical fixo, menos espaço para a grade
- *Dropdown* → não é acessível para crianças

**Por que chips horizontais:** Mantém a grade como área principal, permite rolagem horizontal rápida entre categorias, e o chip selecionado fica sempre visível. Padrão comum em apps AAC (ex: Proloquo2Go, Livox).

**Implementação:**
```dart
// Estrutura do ConverseScreen reformulado
Column(
  SentenceBar (com reordenação + highlight),
  Row(backspace, speak, clear, save),
  CategoryChipBar (horizontal, scrollable),
  Expanded(
    CardGrid (filtrado pela categoria selecionada),
  ),
)
```

### D2 — Reordenação: ReorderableListView na sentence bar

**Decisão:** Substituir o ListView horizontal da sentence bar por `ReorderableListView` (direção horizontal com wrapping em Row). Long-press inicia o arrasto.

**Alternativas consideradas:**
- *Botões de seta (mover left/right)* → mais toques necessários, menos intuitivo
- *Tap + drag nativo* → ReorderableListView é a solução nativa do Flutter

**Remoção específica:** Tap curto em um mini-card → chama `removeCardAt(index)` no `SentenceNotifier`. Adicionar método `removeAt(int index)`.

### D3 — Feedback visual TTS: Estado reativo no SentenceNotifier

**Decisão:** `SentenceNotifier` ganha um campo `int? speakingIndex` que indica qual card está sendo falado. O `LanguageService.speak()` aceita uma lista e itera chamando um callback `onCardSpeak(int index)`.

**Fluxo:**
1. Usuário aperta "Falar"
2. ConverseScreen chama `sentenceNotifier.speakSentence(ttsService, languageService)`
3. Para cada card: `sentenceNotifier.setSpeakingIndex(i)` → TTS fala → aguarda `onComplete` → avança
4. `sentenceBar` escuta `speakingIndex` e aplica destaque (ex: borda animada, fundo diferente)
5. Ao terminar: `sentenceNotifier.setSpeakingIndex(null)`

**Alternativas consideradas:**
- *Stream de eventos separada* → mais complexidade, sem ganho real sobre estado reativo no provider já existente

### D4 — Persistência de frases salvas: SharedPreferences + JSON

**Decisão:** Usar `SharedPreferences` para persistir frases salvas como JSON string (`List<SavedPhrase>`). Cada frase contém um `id` (UUID), `nome` (opcional), e lista de `cardIds`.

**Alternativas consideradas:**
- *SQLite/Drift* → mais pesado para o volume atual (dezenas de frases)
- *Hive/Isar* → nova dependência para poucos dados
- *SharedPreferences* → já é usado para settings, suficiente para frases salvas

**Implementação:**
```dart
class SavedPhrase {
  final String id;
  final String? name;
  final List<String> cardIds; // IDs dos pictogram cards
  final DateTime createdAt;
}

class SavedPhrasesNotifier extends StateNotifier<List<SavedPhrase>> {
  // load() — carrega do SharedPreferences
  // save(phrase) — adiciona e persiste
  // delete(id) — remove e persiste
  // reuse(id) — carrega cards na sentence bar
}
```

Provider: `savedPhrasesProvider = StateNotifierProvider<SavedPhrasesNotifier, List<SavedPhrase>>`

### D5 — Alto contraste: DesignTokens separado + Provider de tema

**Decisão:** Criar `_DesignColorsHighContrast` com cores de alto contraste (fundo escuro ou branco puro, texto preto/branco, bordas grossas). Adicionar um provider `highContrastProvider` (StateProvider\<bool\>) que a SettingsScreen alterna e o AppTheme consulta.

**Fluxo:**
1. `AppTheme.highContrast()` retorna `ThemeData` com cores de alto contraste reais
2. SettingsScreen: novo toggle "Alto Contraste" / "High Contrast"
3. Provider `highContrastModeProvider` persistido no SharedPreferences
4. `main.dart` ou `app.dart` escuta o provider e aplica o tema correto

**Paleta de alto contraste:**
- Background: `#000000` (preto) ou `#FFFFFF` (branco) — toggle entre dark/light high-contrast
- Texto: branco no fundo escuro, preto no fundo claro
- Brand: amarelo `#FFFF00` ou laranja `#FFA500` para destaque
- Bordas: `3px` sólidas (vs 1.5px atuais)
- Touch targets mantidos em 56dp mínimo

### D6 — Estrutura de providers atualizada

```
sentenceProvider → SentenceNotifier
  + addCard(card)
  + removeAt(index)
  + reorder(oldIndex, newIndex)
  + removeLast()
  + clear()
  + speakSentence(languageService, ttsService)  // async, atualiza speakingIndex
  + speakingIndex: int?

savedPhrasesProvider → SavedPhrasesNotifier
  + phrases: List<SavedPhrase>
  + save(name?, cards)
  + delete(id)
  + loadInto(id)  // carrega frase salva na sentence

highContrastModeProvider → StateProvider<bool>
```

## Risks / Trade-offs

- **[Risk] TTS sem callback de progresso em alguns dispositivos:** `flutter_tts` pode não emitir `onProgress` em todos os Android. **Mitigação:** Usar `await tts.speak()` + timer entre cards como fallback; o `speakingIndex` avança sequencialmente.
- **[Risk] ReorderableListView em horizontal:** O widget nativo do Flutter para reordenação horizontal tem limitações. **Mitigação:** Testar em dispositivos reais; fallback para botões de seta se o drag-and-drop for problemático.
- **[Trade-off] SharedPreferences para frases:** Não escala para centenas de frases. **Mitigação:** Se houver necessidade futura, migrar para SQLite/Isar — a abstração `SavedPhrasesRepository` facilita a troca.
- **[Trade-off] Chips horizontais ocupam espaço vertical:** Reduz a área da grade de cards. **Mitigação:** Os chips têm altura fixa ~48dp; a grade usa `Expanded`. Em landscape, a categoria pode recolher para ícone apenas.
