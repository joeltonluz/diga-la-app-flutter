## Why

O Diga Lá terá suporte bilíngue PT–EN em todos os seus modos (Conversar e Aprender). Antes de implementar a UI de configuração de idioma ou o modo bilíngue propriamente dito, o modelo de dados precisa ser estendido para suportar dois rótulos por cartão. Esta change é a fundação de dados para todo o comportamento bilíngue futuro.

## What Changes

- **Modelo `Card` estendido**: o campo `label` (string única) é substituído por `labelPt` e `labelEn` (duas strings obrigatórias).
- **Retrocompatibilidade mantida**: um getter `label` é mantido como alias para `labelPt`, então todo código existente que lê `card.label` continua funcionando sem alterações.
- **Lista fixa atualizada**: cada cartão ganha seu rótulo em inglês (água/water, comida/food, etc.).
- `TtsService` e `ConverseScreen` não precisam mudar — ainda falam `card.label` (que continua sendo PT-BR).

## Capabilities

### New Capabilities

Nenhuma — o behavior do sistema não muda, apenas o modelo de dados.

### Modified Capabilities

- `card-grid`: O modelo `Card` passa de `label` único para `labelPt` + `labelEn` com getter `label` retrocompatível. A lista de cartões fixos é atualizada com os rótulos EN.

## Impact

- `lib/models/card.dart` — campo `label` substituído por `labelPt`, `labelEn` + getter `label`
- `lib/data/sample_cards.dart` — todos os 10 cartões ganham `labelEn`
- Nenhuma outra mudança em runtime (TTS, telas, widgets permanecem idênticos)
