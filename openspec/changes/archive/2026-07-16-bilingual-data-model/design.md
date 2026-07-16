## Context

O modelo `Card` atual (`card-grid-tts`) possui um único campo `label` (String). Para suportar o comportamento bilíngue planejado (PT-BR como padrão, EN como segundo idioma), o modelo precisa armazenar dois rótulos por cartão. Esta change modifica apenas a camada de dados — nenhuma funcionalidade de usuário final muda.

## Goals / Non-Goals

**Goals:**
- Modelo `Card` com `labelPt` (String) e `labelEn` (String).
- Getter `label` retrocompatível retornando `labelPt`.
- Lista fixa de cartões atualizada com `labelEn` para todos os 10 cartões.
- `ConverseScreen` e `CardTile` continuam funcionando sem alterações.

**Non-Goals:**
- UI ou serviço de seleção de idioma (change `language-settings`).
- Falar em EN ou alternar idioma dinamicamente.
- Categorias ou Modo Aprender.
- Persistência em banco.

## Decisions

### 1. Formato do modelo bilíngue: campos explícitos vs mapa de locales

**Escolha: campos explícitos `labelPt` e `labelEn`**

Alternativa considerada: um `Map<String, String>` onde a chave é o código do locale (`pt`, `en`). Rejeitada porque:
- Perde type-safety: qualquer string pode ser chave.
- Dificulta a descoberta em IDE (autocomplete nos campos).
- Adiciona complexidade desnecessária para apenas dois idiomas fixos.
- Quando cartões personalizados forem criados (change `custom-cards-camera`), o cuidador preencherá campos explícitos em um formulário — um mapa esconderia isso.

Campos explícitos são mais simples, type-safe e extensíveis. Se no futuro houver mais idiomas, adicionar `labelEs`, `labelFr` etc. é trivial e não quebra código existente.

### 2. Retrocompatibilidade via getter

```dart
class Card {
  final String id;
  final String labelPt;
  final String labelEn;
  final String emoji;

  String get label => labelPt;
}
```

- Todo código que usa `card.label` continua compilando e retornando PT-BR.
- `ConverseScreen.onTap` → `tts.speak(card.label)` → fala PT-BR (inalterado).
- Quando a configuração de idioma existir, o código mudará para `card.labelPt` ou `card.labelEn` conforme a escolha do usuário.

### 3. Lista fixa bilíngue

Cada entrada em `sample_cards.dart` ganha o parâmetro `labelEn`:

| id | labelPt | labelEn | emoji |
|---|---|---|---|
| agua | água | water | 💧 |
| comida | comida | food | 🍽️ |
| banheiro | banheiro | bathroom | 🚽 |
| dormir | dormir | sleep | 🛏️ |
| brincar | brincar | play | 🧸 |
| casa | casa | home | 🏠 |
| sim | sim | yes | 👍 |
| nao | não | no | 👎 |
| quero | quero | want | 🙋 |
| acabou | acabou | finished | ✅ |

Traduções escolhidas por serem as mais frequentes no contexto de CAA e compreensíveis para o público-alvo.

### 4. Nenhuma mudança em widgets ou telas

`CardTile` exibe `card.label` (getter → `labelPt`). `ConverseScreen` chama `tts.speak(card.label)`. Ambos continuam idênticos. A retrocompatibilidade é total e verificável por compilação.

## Risks / Trade-offs

| Risco | Mitigação |
|---|---|
| Código futuro pode acidentalmente usar `card.label` esperando o idioma ativo, não PT-BR | O getter `label` é intencionalmente mantido como atalho para PT-BR; códigos que precisarem do idioma ativo usarão `labelPt`/`labelEn` explicitamente |
| Adicionar mais idiomas no futuro exige novo campo e nova migration dos dados fixos | A mesma abordagem de campos explícitos se aplica; cartões em banco (change futura) precisarão de migration |
