## Why

O projeto "Diga Lá" foi clonado de um template `flutter create` e atualmente contém apenas o boilerplate padrão (contador, comentários tutoriais, tema genérico). Para começar a construir o aplicativo de CAA, precisamos de um esqueleto limpo, organizado e configurado com as tecnologias-base do projeto. Esta change estabelece a fundação sobre a qual todas as funcionalidades futuras serão construídas.

## What Changes

- **Limpeza total** do boilerplate `flutter create`: remoção do contador de exemplo, FloatingActionButton, comentários tutoriais e textos padrão de `main.dart` e `pubspec.yaml`.
- **Organização de pastas** em `lib/` estruturada por função (screens, widgets, theme, services).
- **Adição das dependências-base**: `flutter_tts` e o pacote de estado e persistência escolhidos.
- **Tema inclusivo**: cores suaves, tipografia legível, alvos de toque grandes, estrutura preparada para alto contraste.
- **Navegação entre dois modos**: tela inicial com logo "Diga Lá" e botões "Conversar" e "Aprender" levando a placeholders.
- **Branding**: logo em `assets/`, nome exibido "Diga Lá", ícone gerado com `flutter_launcher_icons`.
- **TTS testável**: serviço `flutter_tts` configurado e botão temporário de teste na tela inicial.
- **Substituição dos testes de exemplo** por um teste mínimo que valida a nova tela inicial.

## Capabilities

### New Capabilities

- `app-shell`: Estrutura base do app — MaterialApp, tema, navegação entre telas, e organização de pastas.
- `tts-service`: Serviço de text-to-speech configurado com flutter_tts, suporte PT-BR e EN.

### Modified Capabilities

Nenhuma — primeiro change do projeto.

## Impact

- `lib/main.dart`: reescrito completamente.
- `pubspec.yaml`: dependências adicionadas, assets registrados, seção de comentários limpa.
- `test/widget_test.dart`: substituído por teste da nova tela inicial.
- `android/app/src/main/AndroidManifest.xml`: label alterado para "Diga Lá".
- `assets/logo.png`: novo arquivo de logo.
- Novos arquivos em `lib/screens/`, `lib/theme/`, `lib/services/`, `lib/widgets/`.
- <!-- begin: remove when implementation starts -->
- `flutter_launcher_icons` configurado em `pubspec.yaml` e ícones gerados via CLI.
- <!-- end: remove when implementation starts -->
