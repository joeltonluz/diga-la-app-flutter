## Context

A ConverseScreen atual já possui a estrutura funcional: SentenceBar, _SecondaryButton (backspace/delete), GridView 3 colunas com CardTile, e _speakSentence. A change fix-screens-theme-usage já corrigiu o consumo de tokens na _SecondaryButton. O que falta é alinhar o visual ao mockup e a lista de cartões.

## Goals / Non-Goals

**Goals:**
- AppBar: botão voltar (Navigator.pop) + título "Conversar" centralizado
- Botão Falar: ElevatedButton com texto "Falar", usando estilo do tema
- APAGAR (backspace) como _SecondaryButton, Limpar (delete) como _SecondaryButton — ambos já existem, apenas manter
- Grade: 3 colunas (já OK), cartões com tokens (já OK via CardTile)
- Lista de cartões: 12 específicos do mockup
- Barra de frase com altura fixa (já implementado via SentenceBar)
- Testes: apagar remove último, limpar esvazia, grade renderiza, Falar dispara fala

**Non-Goals:**
- Mudanças na SentenceBar, CardTile ou DesignTokens
- Redesenho de outras telas
- Novo modelo de dados ou providers
- Layout responsivo além do existente (landscape/portrait)

## Decisions

### 1. AppBar com botão voltar
Usar `AppBar(leading: IconButton(...), title: const Text('Conversar'), centerTitle: true)`. O `leading` com `Icons.arrow_back_rounded` já segue o padrão do material design. `Navigator.pop(context)` no onPressed.

### 2. Botão Falar como ElevatedButton
Substituir o `GestureDetector` + `AnimatedContainer` circular por um `ElevatedButton.icon` com ícone `Icons.play_arrow_rounded` e texto "Falar". Usar `onPressed: hasCards ? _speakSentence : null` — quando null, o ElevatedButton já fica visualmente inativo por padrão do tema.

### 3. Layout da linha de ações
A linha abaixo da SentenceBar terá 3 botões:
- APAGAR (`_SecondaryButton` com `Icons.backspace_rounded` + `_removeLast`)
- Falar (`ElevatedButton` centralizado, maior)
- Limpar (`_SecondaryButton` com `Icons.delete_rounded` + `_clearSentence`)

### 4. Lista de cartões
Substituir `sample_cards.dart` pelos 12 cartões do mockup. Nenhum cartão fora da lista. Usar o modelo `Card` existente (id, labelPt, labelEn, emoji). Novos: comer (🍽️, antes era comida), ajuda (🆘), parar (🛑), obrigado (🙏). Removidos: comida, dormir, casa, acabou, nao_lig, por_favor.

### 5. Testes
- `test/screens/converse_screen_test.dart` com:
  - Apagar remove último cartão — adicionar 2+, apagar 1, verificar que resta 1
  - Apagar com frase vazia não quebra
  - Limpar esvazia frase inteira
  - Grade renderiza todos os 12 cartões
  - Falar é ElevatedButton
  - Título é "Conversar"

## Risks / Trade-offs

- **[Regressão de layout]** Substituir o círculo animado do Falar por ElevatedButton pode afetar o alinhamento da linha. **Mitigação:** usar Row com espaçamento consistente; ajustar alturas para 48dp (padrão do ElevatedButton).
- **[Testes quebrados]** Testes existentes que verificam títulos ou comportamentos específicos podem falhar. **Mitigação:** executar `flutter test` completo após mudanças.
- **[Cartões removidos]** Apps existentes podem perder acesso a cartões como "comida" e "casa". **Mitigação:** esta change alinha a lista ao mockup aprovado; os cartões removidos não fazem parte do escopo aprovado.
