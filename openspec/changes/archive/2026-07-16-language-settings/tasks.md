## 1. Dependência de persistência

- [ ] 1.1 Adicionar `shared_preferences` ao `pubspec.yaml`
- [ ] 1.2 Rodar `flutter pub get`

## 2. LanguageService e LanguageMode

- [ ] 2.1 Criar enum `LanguageMode` com valores `pt`, `en`, `ptEn` em `lib/services/language_service.dart`
- [ ] 2.2 Criar classe `LanguageService` com construtor que recebe `TtsService` e carrega a preferência salva de `SharedPreferences` (padrão: `pt`)
- [ ] 2.3 Implementar método `speak(Card card)` que fala conforme o modo: PT → `labelPt` em pt-BR, EN → `labelEn` em en-US, PT+EN → ambos em sequência
- [ ] 2.4 Implementar método `setMode(LanguageMode mode)` que salva em `SharedPreferences` e atualiza o modo atual
- [ ] 2.5 Implementar getter `currentMode` e/ou stream para que a UI possa reagir à mudança

## 3. Provider Riverpod

- [ ] 3.1 Criar `lib/providers/language_provider.dart` expondo `LanguageService` como singleton via Riverpod

## 4. Tela de Configurações

- [ ] 4.1 Criar `lib/screens/settings_screen.dart` com três `RadioListTile` grandes (56dp altura mínima) para cada modo de idioma, com título e descrição
- [ ] 4.2 Aplicar design inclusivo: cores suaves, toques grandes, labels claros
- [ ] 4.3 Ao selecionar um modo, chamar `languageService.setMode()` e persistir imediatamente

## 5. Navegação para Configurações

- [ ] 5.1 Adicionar rota `/settings` em `lib/app.dart`
- [ ] 5.2 Adicionar ícone de engrenagem (⚙️ ou `Icons.settings`) no AppBar da `HomeScreen` que navega para `/settings`

## 6. Integrar LanguageService no Modo Conversar

- [ ] 6.1 Em `lib/screens/converse_screen.dart`, obter `LanguageService` do provider e substituir `tts.speak(card.label)` por `languageService.speak(card)`
- [ ] 6.2 Remover a referência direta a `ttsServiceProvider` da `ConverseScreen` (o TTS agora é gerenciado internamente pelo `LanguageService`)

## 7. Verificação

- [ ] 7.1 Rodar `flutter analyze` e confirmar 0 warnings/errors
- [ ] 7.2 Rodar `flutter test` e confirmar que todos os testes passam
- [ ] 7.3 Verificar que o modo padrão (PT) fala em português como antes
- [ ] 7.4 Verificar que a preferência persiste após fechar e reabrir o app
