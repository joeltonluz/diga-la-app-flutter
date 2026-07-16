## Context

O projeto é um app Flutter Android (APK avulso) 100% offline, sem backend, sem login. Atualmente o repositório contém apenas o boilerplate `flutter create`. Esta change estabelece o esqueleto: tema inclusivo, navegação entre dois modos, branding e serviço de TTS.

As duas decisões técnicas deixadas em aberto no project.md — persistência local (sqflite vs Hive) e gerenciamento de estado (Riverpod vs Provider) — precisam ser fechadas agora porque as escolhas de dependências e arquitetura impactam a estrutura do projeto desde o início.

## Goals / Non-Goals

**Goals:**
- Projeto Flutter limpo, sem boilerplate de exemplo.
- Estrutura de pastas em `lib/` organizada e justificada.
- Tema inclusivo com cores suaves, tipografia legível e alvos de toque grandes.
- Navegação entre tela inicial (Início), Modo Conversar e Modo Aprender.
- Branding "Diga Lá": logo em assets/, label do app, ícone gerado.
- Serviço TTS configurado e testável com botão temporário.
- Dependências-base adicionadas ao pubspec.yaml.

**Non-Goals:**
- Funcionalidade de usuário final (grade de cartões, frases, categorias).
- Persistência de dados (será em change futura).
- Modo alto contraste funcional (apenas estrutura preparada).
- Reconhecimento de imagem.
- Testes além do smoke test básico da tela inicial.

## Decisions

### 1. Gerenciamento de estado: Riverpod (vs Provider)

**Escolha: Riverpod (flutter_riverpod + riverpod_annotation)**

**Justificativa:**
- Riverpod é a evolução natural do Provider, mantido pelos mesmos autores.
- Riverpod é compil-safe: erros de provider são detectados em tempo de compilação, não em runtime.
- Riverpod não depende do widget tree — providers podem ser lidos em qualquer lugar sem depender de `BuildContext`, o que é crucial para o serviço de TTS que pode ser invocado de múltiplos pontos (grade de cartões, modo aprender, frase).
- Riverpod suporta `AsyncValue` nativamente, facilitando o tratamento de estados de carregamento/erro para futuras operações assíncronas (persistência, TTS).
- Provider, embora mais leve e suficiente para este setup inicial, criaria um débito técnico maior para migrar depois. Como a preferência do project.md já é Riverpod, não há razão para escolher Provider.

### 2. Persistência local: Hive (vs sqflite)

**Escolha: Hive (hive + hive_flutter)**

**Justificativa:**
- O app lida com dados estruturados simples: cartões (imagem, nome, áudio), categorias (nome, lista de cartões). Não há relacionamentos complexos que exijam SQL.
- Hive é mais rápido que sqflite em operações de leitura/escrita para dados do tipo chave-valor, que é o padrão de uso esperado (ler cartões de uma categoria, salvar um novo cartão).
- Hive é tipo-safe com tipagem customizada via `TypeAdapter`, o que se alinha bem com Dart.
- Hive não requer SQL, reduzindo a complexidade cognitiva para futuras manutenções.
- sqflite seria mais adequado se houvesse consultas complexas (joins, filtros agregados), o que não é o caso. O padrão de acesso será "buscar todos os cartões de uma categoria" e "salvar/atualizar cartão", ambos triviais em Hive.
- **Trade-off:** Hive não é tão adequado para migrações de schema complexas. Se no futuro o modelo de dados crescer significativamente, uma migração para sqflite pode ser necessária. Isso é mitigado mantendo os adaptadores Hive isolados atrás de uma interface de repositório (`lib/services/repository.dart`), permitindo troca futura sem impacto no resto do app.

### 3. Estrutura de pastas em lib/

```
lib/
├── main.dart                    # Entry point, MaterialApp, roteamento
├── app.dart                     # Widget raiz do MaterialApp
├── screens/
│   ├── home_screen.dart         # Tela inicial com logo e botões
│   ├── converse_screen.dart     # Placeholder Modo Conversar
│   └── learn_screen.dart        # Placeholder Modo Aprender
├── widgets/
│   └── temp_tts_button.dart     # Botão temporário de teste TTS
├── theme/
│   └── app_theme.dart           # Tema inclusivo (cores, tipografia, dimensões)
├── services/
│   └── tts_service.dart         # Serviço flutter_tts (singleton/provider)
└── providers/
    └── tts_provider.dart        # Provider Riverpod para TTS
```

**Justificativa:**
- `screens/`: Separação clara de telas; cada tela é um widget completo. Padrão Flutter idiomático.
- `widgets/`: Componentes reutilizáveis que não são telas completas. O botão TTS temporário fica aqui.
- `theme/`: Isola toda a configuração de tema (cores, texto, dimensões). Facilita a adição do modo alto contraste no futuro — bastará criar um `AppTheme.highContrast()` alternativo.
- `services/`: Classes de serviço que encapsulam dependências externas (TTS, futuramente persistência). Facilitam teste e troca de implementação.
- `providers/`: Providers Riverpod. Separados dos serviços para seguir a convenção Riverpod e permitir injeção independente.
- `app.dart`: Extrair o MaterialApp para um widget separado é uma boa prática que facilita testes de widget (o app pode ser instanciado sem o `main()`).

### 4. Navegação

- Uso de `Navigator 1.0` (pushNamed) para as duas telas placeholder. Navegação simples o suficiente para não justificar o pacote `go_router` nesta fase.
- A tela inicial (home) usa `pushReplacement` conceitualmente — na prática, botões chamam `Navigator.push` para Conversar/Aprender, e cada tela placeholder tem um `back` para voltar ao início.

### 5. Tema inclusivo (diretrizes)

- **Paleta:** Azul acinzentado suave (#6B8E9B ou similar) como primária, creme (#F5F0E8) como fundo, rosa suave (#D4A5A5) como acento. Saturação abaixo de 30% para evitar estímulos agressivos.
- **Tipografia:** Font size mínimo 18dp para corpo, 24dp para títulos. Família sans-serif (padrão do sistema) para máxima legibilidade.
- **Touch targets:** Botões com no mínimo 56dp de altura (acima do mínimo WCAG de 44dp). Espaçamento generoso de 16dp entre elementos.
- **Modo alto contraste:** A estrutura de tema (`AppTheme`) é projetada como classe com dois construtores nomeados: `AppTheme.regular()` e futuramente `AppTheme.highContrast()`.

### 6. Flutter_launcher_icons e logo

- O logo (`assets/logo.png`) tem fundo branco. Ícones adaptativos Android exigem foreground (transparente) e background separados.
- **Decisão:** Configurar `flutter_launcher_icons` com `image_path: "assets/logo.png"` que gera ícones não-adaptativos (API < 26). Para API 26+, será necessário extrair um foreground sem fundo. Isso fica registrado como pendência — o ícone gerado funcionará, mas pode não ser adaptativo em versões recentes do Android. A solução ideal (criar `assets/logo_foreground.png` com fundo transparente) será tratada quando o logo final estiver disponível.

## Risks / Trade-offs

| Risco | Mitigação |
|---|---|
| Hive pode não ser adequado se o modelo de dados crescer com relacionamentos complexos | Isolar atrás de interface de repositório desde o início |
| Logo PNG com fundo branco pode não funcionar como foreground de ícone adaptativo | Registrado como pendência; ícone não-adaptativo funciona em todas as APIs |
| flutter_tts pode ter latência ou qualidade variável em dispositivos Android de baixo custo | O botão temporário de teste permite validar em cada dispositivo alvo |
| Riverpod adiciona complexidade vs Provider para um app que começa simples | A complexidade é compensada pela segurança de tipos e testabilidade |
