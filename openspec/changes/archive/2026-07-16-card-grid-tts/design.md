## Context

O Modo Conversar é a tela principal de CAA do Diga Lá. Atualmente é um placeholder vazio. O TTS já está configurado e funcional (setup-project). Esta change transforma o placeholder em uma grade de cartões que falam ao toque — o mecanismo central de expressão do app.

## Goals / Non-Goals

**Goals:**
- Modelo de dados `Card` (id, texto, emoji).
- Lista fixa de 10 cartões iniciais.
- Grade responsiva na tela Conversar.
- Ao tocar um cartão, TTS fala o texto.
- Feedback visual discreto ao toque.
- Remoção do botão temporário de TTS da tela inicial.

**Non-Goals:**
- Barra de frase para encadear cartões (change `sentence-bar`).
- Criar/editar cartões ou câmera (change `custom-cards-camera`).
- Persistência (change `persistence-local`).
- Categorias (change `learn-mode-categories`).
- Modo aprender.

## Decisions

### 1. Modelo Card

```dart
class Card {
  final String id;
  final String label;    // texto falado (ex.: "água")
  final String emoji;    // representação visual (ex.: "💧")
}
```

- `id`: identificador único. Usar o label em lowercase como id (ex.: `agua`). Suficiente para cartões fixos; será ajustado quando houver persistência.
- `label`: texto que o TTS fala e que aparece abaixo do emoji.
- `emoji`: representação visual. Escolha deliberada: emojis são familiares, coloridos, não exigem assets de imagem e funcionam em qualquer resolução. Quando a change de câmera permitir fotos reais, o campo `emoji` será substituído por `imagePath` ou similar, mas o contrato visual do `CardTile` permanece o mesmo.

### 2. Lista fixa de cartões (`sample_cards.dart`)

Os 10 cartões iniciais vivem em uma `List<Card>` constante em `lib/data/sample_cards.dart`. A escolha dos cartões prioriza necessidades básicas de comunicação:

| Label | Emoji | Uso |
|---|---|---|
| água | 💧 | Sede / beber |
| comida | 🍽️ | Fome / comer |
| banheiro | 🚽 | Ir ao banheiro |
| dormir | 🛏️ | Sono / cansado |
| brincar | 🧸 | Brincar / lazer |
| casa | 🏠 | Ir para casa / estar em casa |
| sim | 👍 | Afirmação |
| não | 👎 | Negação |
| quero | 🙋 | Desejo / pedir |
| acabou | ✅ | Finalizou / terminou / chega |

### 3. CardTile como widget reusável

`CardTile` é um `StatelessWidget` que recebe um `Card` e uma função `onTap`. O widget:
- Ocupa espaço quadrado generoso (~80dp x 80dp).
- Exibe emoji grande (40dp) acima do label (14dp).
- Tem fundo branco com borda arredondada e sombra suave.
- Ao toque: `onPressed` com feedback visual (InkWell com splash suave).
- A função `onTap` é injetada de fora — o `CardTile` não conhece TTS diretamente. Isso mantém o widget puramente visual e reusável (ex.: poderá ser usado no modo Aprender sem TTS, ou com TTS em outro idioma).

### 4. Grade na ConverseScreen

`GridView.count` com `crossAxisCount: 2` (mobile retrato), 3 em tablets/wide. O `padding` e espaçamento seguem o tema inclusivo (16dp). A `ConverseScreen` obtém a lista de `sample_cards.dart`, itera e cria `CardTile` para cada um. O `onTap` chama `ref.read(ttsServiceProvider).speak(card.label)`.

### 5. Remoção do botão TTS temporário

O `TempTtsButton` na tela inicial foi adicionado no setup para validar o TTS. Com a grade funcional, ele perde a utilidade e é removido junto com sua importação na `HomeScreen`.

### 6. Sem estado mutável (ainda)

Os cartões são fixos e imutáveis. Não há estado de seleção, nem frase sendo montada. Isso simplifica esta change e adia a complexidade para `sentence-bar`.

## Risks / Trade-offs

| Risco | Mitigação |
|---|---|
| Emojis podem renderizar diferente em cada dispositivo Android | Usar emojis universais (Unicode padrão); evitar variações de pele ou bandeiras |
| Lista fixa de 10 cartões pode não atender todas as crianças | É propositalmente mínima; cartões customizáveis virão na change `custom-cards-camera` |
| Grid 2 colunas pode ser pouco para quadro de cartões maior | O `crossAxisCount` é facilmente ajustável; a grade se adapta dinamicamente |
