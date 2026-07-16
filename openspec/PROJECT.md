# Diga Lá

## Visão geral

**Diga Lá** é um aplicativo Flutter de Comunicação Aumentativa e Alternativa
(CAA) para crianças autistas não-verbais ou com fala mínima, com um segundo
modo de aprendizado de vocabulário bilíngue.

Motivação: construído a partir de uma necessidade real — uma criança de 9 anos,
nível 3 de suporte, que fala muito pouco. O propósito central é **dar voz**:
permitir que a criança se expresse tocando em imagens que o aparelho fala em voz
alta.

O app tem dois modos que compartilham o mesmo motor (grade de imagens tocáveis
+ voz):

1. **Modo Conversar (CAA):** a criança toca cartões, monta uma frase e o app
   fala em voz alta. Ferramenta de **expressão** — dizer o que quer, sente ou
   precisa.
2. **Modo Aprender:** livro interativo por categorias (animais, frutas,
   transportes, partes do corpo, cores), bilíngue PT–EN. Ferramenta de
   **aprendizado** de vocabulário por associação visual e auditiva.

## Idioma (bilíngue global)

- O comportamento bilíngue (PT + EN) é **global**, controlado por uma
  **configuração central salva no aparelho**, e vale para os **dois modos**
  (Conversar e Aprender).
- Cada cartão/item carrega rótulo em **PT e EN**.
- A configuração define como o app fala (ex.: só PT, só EN, ou PT+EN em
  sequência). Todos os modos consultam esse serviço central na hora de falar —
  nenhum modo resolve idioma por conta própria.

## Restrições técnicas (não-negociáveis)

- **Framework:** Flutter (Dart).
- **Alvo:** Android, distribuído como **APK avulso (standalone)**.
- **Sem backend, sem servidor, sem login, sem chamadas de rede.**
- **100% offline.** Todo processamento e persistência acontecem no dispositivo.
- **Persistência local:** SQLite (`sqflite`) ou `Hive` — a escolha e sua
  justificativa devem ser registradas no `design.md` da change que primeiro
  introduzir persistência (`language-settings`).
- **Text-to-speech:** `flutter_tts`, com suporte a **PT-BR** e **EN**.
- **Gerência de estado:** Riverpod (preferência) ou Provider — a escolha e sua
  justificativa devem ser registradas no `design.md` da change de setup.
- **Reconhecimento de imagem (se e quando existir):** deve ser **on-device**
  (Google ML Kit ou TensorFlow Lite via `tflite_flutter`). Nunca enviar imagem
  para a nuvem. Isso **não é MCP** e não envolve nenhum serviço externo.
- **QR code (tela Sobre):** gerado **localmente** no app (ex.: `qr_flutter`) a
  partir de uma URL pública. Nada é enviado para fora do aparelho.

## Privacidade (requisito, não enfeite)

- Fotos e áudios criados pelo cuidador podem incluir a família da criança e
  **nunca saem do aparelho**.
- Nenhuma telemetria, analytics ou coleta de dados.
- Nenhuma permissão de rede necessária para o funcionamento do app.
- A tela "Sobre o desenvolvedor" usa apenas **informações públicas do
  desenvolvedor (adulto)** — nunca dados da criança.

## Princípios de design inclusivo (não-negociáveis)

- **Baixa carga sensorial:** cores suaves, sem sons abruptos, sem flashes.
- **Animações discretas e desativáveis** (respeitar redução de movimento).
- **Alvos de toque grandes e generosos** (mínimo 44x44 dp, de preferência
  maiores).
- **Interface previsível e consistente:** nada de mudanças bruscas de layout.
- **Modo de alto contraste** opcional.
- **Tudo customizável pelo cuidador:** cartões, imagens, áudios e vocabulário.

## Identidade visual

- Nome exibido do app: **Diga Lá**.
- Logo: balão de fala com carinha sorridente, em cores suaves (azul acinzentado,
  creme, toque de rosa). O próprio logo respeita o princípio de baixa carga
  sensorial.
- Ícone do app gerado a partir de `assets/logo.png`.

## Fora de escopo (por enquanto)

- iOS.
- Publicação em lojas de aplicativos.
- Contas de usuário e autenticação.
- Sincronização em nuvem.
- Qualquer analytics ou telemetria.

## Roadmap de changes

Concluídas:
1. `setup-project` ✅ — esqueleto, tema, navegação, branding, TTS testável.
2. `card-grid-tts` ✅ — grade de cartões que falam ao toque (Modo Conversar).

A fazer (nesta ordem):
3. `bilingual-data-model` — estender o modelo de cartão/item para carregar
   rótulo em PT e EN; atualizar a lista fixa do Modo Conversar. Só dados/modelo.
4. `language-settings` — configuração central de idioma salva no aparelho
   (primeiro uso de persistência local) e serviço que todo o app consulta.
5. `learn-mode-categories` — modo aprender com categorias fixas, consumindo o
   modelo bilíngue e a configuração central.
6. `sentence-bar` — barra que encadeia cartões numa frase e fala tudo (CAA),
   respeitando a configuração de idioma.
7. `about-developer` — tela "Sobre" com informações do desenvolvedor, link do
   LinkedIn/repositório e QR code gerado localmente (projeto open source).
8. `custom-cards-camera` — criar cartões com foto real + nome (PT e EN) + áudio.
9. `persistence-local` — persistir cartões/categorias do usuário no dispositivo.
10. `on-device-labeling` (opcional) — ML Kit sugere o cartão a partir da câmera.

Princípio de ordem: primeiro o DADO bilíngue (3), depois a CONFIGURAÇÃO que o
controla (4), e só então os modos que CONSOMEM isso (5, 6).