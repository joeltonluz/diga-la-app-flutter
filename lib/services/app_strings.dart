import 'language_service.dart';

class AppStrings {
  static String get(String key, LanguageMode mode) {
    final map = mode == LanguageMode.pt ? _pt : _en;
    return map[key] ?? key;
  }

  static const Map<String, String> _pt = {
    'appTitle': 'Diga Lá',
    'converse': 'Conversar',
    'learn': 'Aprender',
    'settings': 'Configurações',
    'speak': 'Falar',
    'clear': 'Limpar',
    'back': 'Voltar',
    'speechLanguage': 'Idioma de fala',
    'speechLanguageDesc': 'Escolha como o app fala em voz alta os cartões que você tocar.',
    'appLanguage': 'Idioma do app',
    'appLanguageDesc': 'Escolha o idioma dos textos e menus do aplicativo.',
    'portuguese': 'Português',
    'portugueseSpeechDesc': 'Fala os cartões em português do Brasil',
    'portugueseAppDesc': 'Exibe textos em português',
    'english': 'English',
    'englishSpeechDesc': 'Speaks cards in American English',
    'englishAppDesc': 'Displays texts in English',
    'voice': 'VOZ',
    'noVoiceAvailable': 'Nenhuma voz disponível para este idioma.',
    'listen': 'Ouvir',
    'speechRate': 'VELOCIDADE DA FALA',
    'listenExample': 'Ouvir exemplo',
    'verySlow': 'Muito Lento',
    'slow': 'Lento',
    'medium': 'Médio',
    'fast': 'Rápido',
    'emptySentence': 'Toque nos cartões para montar uma frase',
    'previewPhrase': 'Oi, prazer, estou aqui para te ajudar.',
  };

  static const Map<String, String> _en = {
    'appTitle': 'Diga Lá',
    'converse': 'Converse',
    'learn': 'Learn',
    'settings': 'Settings',
    'speak': 'Speak',
    'clear': 'Clear',
    'back': 'Back',
    'speechLanguage': 'Speech language',
    'speechLanguageDesc': 'Choose how the app speaks the cards out loud when you tap them.',
    'appLanguage': 'App language',
    'appLanguageDesc': 'Choose the language for texts and menus.',
    'portuguese': 'Português',
    'portugueseSpeechDesc': 'Speaks cards in Brazilian Portuguese',
    'portugueseAppDesc': 'Displays texts in Portuguese',
    'english': 'English',
    'englishSpeechDesc': 'Speaks cards in American English',
    'englishAppDesc': 'Displays texts in English',
    'voice': 'VOICE',
    'noVoiceAvailable': 'No voices available for this language.',
    'listen': 'Listen',
    'speechRate': 'SPEECH RATE',
    'listenExample': 'Listen example',
    'verySlow': 'Very Slow',
    'slow': 'Slow',
    'medium': 'Medium',
    'fast': 'Fast',
    'emptySentence': 'Tap cards to build a sentence',
    'previewPhrase': "Hi, nice to meet you, I'm here to help you.",
  };
}
