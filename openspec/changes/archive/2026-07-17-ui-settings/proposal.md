## Why

A tela de Configurações atual funciona, mas seu visual destoa do restante do app: usa `theme.colorScheme` diretamente em vez dos tokens do DesignTokens, o AppBar não tem botão voltar (quebra a consistência com as demais telas), e os cartões de opção não seguem o sistema visual estabelecido (cores, bordas, tipografia). O mockup da tela define um layout mais limpo e inclusivo que esta change implementa.

## What Changes

- **AppBar**: adicionar botão voltar circular (mesmo padrão de LearnScreen e CategoryGridScreen)
- **Cartões de idioma**: fundo brand claro + borda brand quando selecionado; fundo surfaceCard + borda borderSoft quando não selecionado; usar `DesignTokens.colors` e `DesignTokens.textStyles` em vez de `theme.colorScheme`
- **Seção Voz**: seção com label em brand; cada voz como linha simples com rádio (brand quando selecionado), nome e botão "Ouvir" secundário; divisórias borderSoft entre linhas
- **Seção Velocidade**: restilizada com DesignTokens, coerente com as demais seções
- **Agrupamento**: seções organizadas em cards/blocos com espaçamento do tema
- **Testes**: expandir o teste existente, TDD: opções de idioma visíveis, seleção reflete no estado, botões "Ouvir" existem por voz, controle de velocidade presente

## Capabilities

### New Capabilities
- *(nenhuma — é refino visual da tela existente)*

### Modified Capabilities
- `language-settings`: visual da tela de configurações (AppBar, cartões de idioma, seção Voz, seção Velocidade) — requisitos de aparência atualizados
- `voice-selection`: visual dos itens de voz na tela (de cartão para linha com divisor)
- `voice-rate`: visual dos itens de velocidade na tela (restilizado com tokens)

## Impact

- `lib/screens/settings_screen.dart`: refatoração visual completa (mantendo lógica)
- `test/screens/settings_screen_test.dart`: novos testes de aparência e estado
