## Context

O app já possui modelo bilíngue (`Card` com `labelPt`/`labelEn`) e o `TtsService` configurado, mas o comportamento de fala é fixo em PT-BR (`card.label` → `labelPt`). Para realizar o bilinguismo global definido no project.md, precisamos de: (1) uma configuração persistida de idioma, (2) um serviço central que todos os modos consultam, e (3) uma tela para o cuidador escolher a preferência. Esta change introduz a primeira persistência real do projeto.

## Goals / Non-Goals

**Goals:**
- Serviço central (`LanguageService`) com três modos: PT, EN, PT+EN.
- Persistência da preferência entre sessões.
- Tela de Configurações acessível da home com seleção inclusiva de idioma.
- Modo Conversar fala conforme a configuração.
- Uso dos campos `labelPt`/`labelEn` já existentes no modelo.

**Non-Goals:**
- Categorias ou Modo Aprender.
- Barra de frase.
- Câmera ou cartões personalizados.
- Qualquer outra configuração além de idioma.

## Decisions

### 1. Persistência: shared_preferences (vs sqflite vs hive)

**Escolha: shared_preferences**

**Justificativa:**
- A preferência é um valor único (String: `"pt"`, `"en"`, ou `"pt_en"`). Não há necessidade de banco relacional ou chave-valor tipado.
- `shared_preferences` é a solução mais simples e leve para pares chave-valor simples.
- Hive e sqflite seriam superdimensionados para uma única string — adicionariam complexidade de inicialização (`Hive.init`, `TypeAdapter`) sem benefício.
- **Coerência com mudanças futuras:** as changes seguintes (`persistence-local`, `custom-cards-camera`) usarão Hive para dados estruturados (cartões, categorias). A preferência de idioma continuará em `shared_preferences` por ser um caso diferente (configuração vs dados do usuário). Manter duas soluções é aceitável porque cada uma resolve um problema diferente com a ferramenta certa.
- Alternativa rejeitada: guardar no `SecureStorage` — não há dado sensível aqui.

### 2. LanguageService: enum LanguageMode e método speak(Card)

```dart
enum LanguageMode { pt, en, ptEn }

class LanguageService {
  final TtsService _tts;
  LanguageMode _mode;

  Future<void> speak(Card card) async {
    switch (_mode) {
      case LanguageMode.pt:
        await _tts.setLanguage('pt-BR');
        await _tts.speak(card.labelPt);
      case LanguageMode.en:
        await _tts.setLanguage('en-US');
        await _tts.speak(card.labelEn);
      case LanguageMode.ptEn:
        await _tts.setLanguage('pt-BR');
        await _tts.speak(card.labelPt);
        await _tts.setLanguage('en-US');
        await _tts.speak(card.labelEn);
    }
  }
}
```

- O serviço recebe `TtsService` por injeção (via Riverpod).
- `speak(Card)` é o método único que os modos chamam. Eles não precisam saber de locale, sequência ou texto — o `LanguageService` decide tudo.
- No modo PT+EN, as duas chamadas são sequenciais. O `flutter_tts` gerencia a fila internamente.

### 3. Persistência e inicialização

- `LanguageService` carrega o modo salvo no construtor (`SharedPreferences.getString('languageMode') ?? 'pt'`).
- Ao mudar a preferência na tela de Configurações, salva imediatamente: `prefs.setString('languageMode', mode)`.
- O provider Riverpod expõe o `LanguageService` como singleton.

### 4. Tela de Configurações

- Acessada por ícone de engrenagem (⚙️) no AppBar da tela inicial.
- Três opções em formato de `RadioListTile` grande (altura mínima 56dp):
  - "Só Português" — descrição: "O app fala em português"
  - "Só Inglês" — descrição: "O app fala em inglês"
  - "Português e Inglês" — descrição: "O app fala os dois, um depois do outro"
- A opção ativa é destacada visualmente.
- Ao selecionar, a preferência é salva e o efeito é imediato.

### 5. Mudança no Modo Conversar

Atual:
```dart
onTap: () => tts.speak(card.label),
```

Novo:
```dart
onTap: () => languageService.speak(card),
```

- `card.label` continua existindo como getter → `labelPt`, mas deixa de ser usado diretamente.
- `TtsService` permanece como dependência interna do `LanguageService`.

## Risks / Trade-offs

| Risco | Mitigação |
|---|---|
| PT+EN sequencial pode demorar em cartões com áudio longo | Aceitável para o uso esperado (palavras curtas de CAA); se houver necessidade, adicionar configuração de pausa entre idiomas |
| shared_preferences não escala para dados complexos | Não é o objetivo — só para configurações simples; dados de cartões/categorias usarão Hive |
| Usuário pode trocar de idioma enquanto o TTS está falando | O LanguageService pode chamar `tts.stop()` antes de iniciar nova fala; flutter_tts gerencia fila |
