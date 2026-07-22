## Why

O logo do app (balão de fala sorridente) já é um símbolo reconhecível, mas não tem nome nem personalidade. Dar a ele o nome "Balô" e uma presença animada sutil transforma o logo em um mascote acolhedor, sem adicionar gamificação ou estímulos que sobrecarreguem o usuário principal (crianças autistas nível 3). Isso humaniza o app sem comprometer a baixa carga sensorial.

## What Changes

1. **Nomear o mascote:** o logo passa a se chamar "Balô" (balão + alô)
2. **Widget reutilizável `BalôWidget`:** centraliza a lógica de aparência + animações do mascote
3. **Animação de respiração no Splash:** escala muito suave (1.0↔1.02, ciclo 3s)
4. **Aceno sutil na Home:** leve rotação ao entrar na tela (1x, -2° a +2°)
5. **Reação ao falar no ConverseScreen:** pulso gentil (scale 1.0→1.05→1.0, 400ms) quando a criança aperta "Falar"
6. **Balô em estados vazios:** exibir Balô com texto gentil ("Toque nos cartões para montar uma frase") em vez de apenas texto
7. **Tudo desligável:** respeitar `disableAnimations` (acessibilidade)

## Capabilities

### New Capabilities
- `mascote-balo`: Widget reutilizável do Balô com animações nativas sutis (respiração, aceno, pulso) e exibição em estados vazios, respeitando redução de movimento

### Modified Capabilities
<!-- Nenhuma capability existente tem requisitos alterados — apenas integração visual nas telas existentes -->

## Impact

- **Novo arquivo:** `lib/widgets/balo_widget.dart` — widget com animações nativas (sem dependências externas)
- **Arquivos modificados:**
  - `lib/screens/splash_screen.dart` — adicionar respiração ao logo
  - `lib/screens/home_screen.dart` — adicionar aceno ao logo
  - `lib/screens/converse_screen.dart` — usar Balô no estado vazio + pulso ao falar
- **Nenhuma dependência nova** — animações com `AnimationController` nativo do Flutter
- **Nenhuma alteração de navegação, modelo de dados ou providers existentes**
