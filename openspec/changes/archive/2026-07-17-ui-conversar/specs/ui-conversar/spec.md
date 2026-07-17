## ADDED Requirements

### Requirement: AppBar tem botão voltar e título "Conversar"
O AppBar da ConverseScreen DEVE ter um botão voltar circular à esquerda e o título centralizado "Conversar" (não "Modo Conversar").

#### Scenario: AppBar exibe título Conversar
- **WHEN** o usuário navega para a ConverseScreen
- **THEN** o título do AppBar é "Conversar"
- **AND** há um botão voltar circular visível

#### Scenario: Botão voltar retorna ao Início
- **WHEN** o usuário toca no botão voltar no AppBar da ConverseScreen
- **THEN** o app navega de volta para a HomeScreen

### Requirement: Botão Falar é ElevatedButton com texto
O botão "Falar" DEVE ser um ElevatedButton com fundo azul (primary), texto "Falar" em branco (onPrimary), com padding e altura mínima de toque. Substitui o ícone circular de play atual.

#### Scenario: Falar é ElevatedButton
- **WHEN** a ConverseScreen é renderizada
- **THEN** o widget do botão Falar é um ElevatedButton com texto "Falar"

#### Scenario: Falar dispara fala da frase
- **WHEN** a barra de frase contém um ou mais cartões
- **WHEN** o usuário toca no botão Falar
- **THEN** o sistema fala cada cartão da frase em sequência via LanguageService.speak()

#### Scenario: Falar fica desabilitado com frase vazia
- **WHEN** a barra de frase está vazia
- **THEN** o botão Falar está desabilitado (sem ação ao tocar)
- **AND** visualmente parece inativo (alpha reduzido)

### Requirement: Grade de cartões tem 3 colunas com tokens do tema
A grade de cartões na ConverseScreen DEVE ter exatamente 3 colunas. Cada cartão DEVE usar DesignTokens para borderRadius (radii.card), fundo (surfaceCard), sombra (shadows.card), e estilo de texto (cardLabel).

#### Scenario: Grade tem 3 colunas
- **WHEN** a ConverseScreen é renderizada
- **THEN** a GridView tem crossAxisCount igual a 3

#### Scenario: Cartão usa borderRadius do tema
- **WHEN** a ConverseScreen renderiza um cartão
- **THEN** o borderRadius do cartão usa DesignTokens.radii.card

### Requirement: Lista de cartões segue o mockup
A lista de cartões de amostra (sample_cards.dart) DEVE conter exatamente estes 12 cartões, nesta ordem: eu, quero, comer, água, sim, não, mais, ajuda, banheiro, brincar, parar, obrigado.

| id | labelPt | labelEn | emoji |
|---|---|---|---|
| eu | eu | I | 👤 |
| quero | quero | want | 🙋 |
| comer | comer | eat | 🍽️ |
| agua | água | water | 💧 |
| sim | sim | yes | 👍 |
| nao | não | no | 👎 |
| mais | mais | more | ➕ |
| ajuda | ajuda | help | 🆘 |
| banheiro | banheiro | bathroom | 🚽 |
| brincar | brincar | play | 🧸 |
| parar | parar | stop | 🛑 |
| obrigado | obrigado | thank you | 🙏 |

#### Scenario: Cartões do mockup existem
- **WHEN** a lista de cartões de amostra é carregada
- **THEN** ela contém todos os 12 cartões listados acima
- **AND** não contém cartões fora dessa lista
