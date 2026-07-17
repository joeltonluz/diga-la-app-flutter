import 'package:flutter/material.dart' hide Card;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/voice.dart';
import '../providers/language_provider.dart';
import '../providers/voice_provider.dart';
import '../services/language_service.dart';
import '../services/voice_service.dart';
import '../theme/design_tokens.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final languageService = ref.watch(languageServiceProvider);
    final voiceService = ref.watch(voiceServiceProvider);
    final current = languageService.currentMode;
    final voices = voiceService.voices;
    final selectedVoice = voiceService.selectedVoice;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Configurações'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        children: [
          _LanguageSection(
            current: current,
            languageService: languageService,
          ),
          const SizedBox(height: 16),
          _VoiceSection(
            voices: voices,
            selectedVoice: selectedVoice,
            voiceService: voiceService,
          ),
          const SizedBox(height: 16),
          _RateSection(voiceService: voiceService),
        ],
      ),
    );
  }
}

class _LanguageSection extends StatelessWidget {
  final LanguageMode current;
  final LanguageService languageService;

  const _LanguageSection({
    required this.current,
    required this.languageService,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: DesignTokens.colors.surfaceCard,
        borderRadius: DesignTokens.radii.card,
        border: Border.all(color: DesignTokens.colors.borderSoft),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Idioma de fala',
            style: DesignTokens.textStyles.labelLarge,
          ),
          const SizedBox(height: 6),
          Text(
            'Escolha como o app fala em voz alta os cartões que você tocar.',
            style: TextStyle(
              fontFamily: DesignTokens.fontFamily,
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: DesignTokens.colors.textSecondary,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 16),
          _LangRow(
            flag: '🇧🇷',
            title: 'Português',
            description: 'Fala os cartões em português do Brasil',
            isSelected: current == LanguageMode.pt,
            onTap: () => languageService.setMode(LanguageMode.pt),
          ),
          const SizedBox(height: 12),
          _LangRow(
            flag: '🇺🇸',
            title: 'English',
            description: 'Speaks cards in American English',
            isSelected: current == LanguageMode.en,
            onTap: () => languageService.setMode(LanguageMode.en),
          ),
        ],
      ),
    );
  }
}

class _LangRow extends StatelessWidget {
  final String flag;
  final String title;
  final String description;
  final bool isSelected;
  final VoidCallback onTap;

  const _LangRow({
    required this.flag,
    required this.title,
    required this.description,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          color: isSelected
              ? DesignTokens.colors.brand.withValues(alpha: 0.08)
              : null,
          borderRadius: DesignTokens.radii.mini,
          border: Border.all(
            color: isSelected
                ? DesignTokens.colors.brand
                : DesignTokens.colors.borderSoft,
            width: isSelected ? 2 : 1.5,
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            Text(flag, style: const TextStyle(fontSize: 32)),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontFamily: DesignTokens.fontFamily,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: DesignTokens.colors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    description,
                    style: TextStyle(
                      fontFamily: DesignTokens.fontFamily,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: DesignTokens.colors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            _Radio26(isSelected: isSelected),
          ],
        ),
      ),
    );
  }
}

class _VoiceSection extends StatelessWidget {
  final List<Voice> voices;
  final Voice? selectedVoice;
  final VoiceService voiceService;

  const _VoiceSection({
    required this.voices,
    required this.selectedVoice,
    required this.voiceService,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: DesignTokens.colors.surfaceCard,
        borderRadius: DesignTokens.radii.card,
        border: Border.all(color: DesignTokens.colors.borderSoft),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'VOZ',
            style: TextStyle(
              fontFamily: DesignTokens.fontFamily,
              fontSize: 13,
              fontWeight: FontWeight.w800,
              letterSpacing: 1,
              color: DesignTokens.colors.brand,
            ),
          ),
          const SizedBox(height: 14),
          if (voices.isEmpty)
            Text(
              'Nenhuma voz disponível para este idioma.',
              style: TextStyle(
                fontFamily: DesignTokens.fontFamily,
                fontSize: 15,
                fontWeight: FontWeight.w400,
                color: DesignTokens.colors.textSecondary,
              ),
            )
          else
            ...voices.map((voice) {
              final isLast = voice == voices.last;
              return _VoiceRow(
                voice: voice,
                isSelected: selectedVoice?.name == voice.name,
                isLast: isLast,
                onTap: () => voiceService.selectVoice(voice),
                onPlay: () => voiceService.previewVoice(voice),
              );
            }),
        ],
      ),
    );
  }
}

class _VoiceRow extends StatelessWidget {
  final Voice voice;
  final bool isSelected;
  final bool isLast;
  final VoidCallback onTap;
  final VoidCallback onPlay;

  const _VoiceRow({
    required this.voice,
    required this.isSelected,
    required this.isLast,
    required this.onTap,
    required this.onPlay,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: isLast
              ? null
              : Border(
                  bottom: BorderSide(
                    color: DesignTokens.colors.borderSoft.withValues(alpha: 0.6),
                  ),
                ),
        ),
        padding: const EdgeInsets.symmetric(vertical: 14),
        child: Row(
          children: [
            _Radio26(isSelected: isSelected),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                voice.name,
                style: TextStyle(
                  fontFamily: DesignTokens.fontFamily,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: DesignTokens.colors.textPrimary,
                ),
              ),
            ),
            GestureDetector(
              onTap: onPlay,
              child: Container(
                height: 44,
                padding: const EdgeInsets.symmetric(horizontal: 18),
                decoration: BoxDecoration(
                  color: DesignTokens.colors.surfaceCard,
                  borderRadius: DesignTokens.radii.mini,
                  border: Border.all(color: DesignTokens.colors.borderSoft),
                ),
                child: Center(
                  child: Text(
                    'Ouvir',
                    style: TextStyle(
                      fontFamily: DesignTokens.fontFamily,
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: DesignTokens.colors.brand,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RateSection extends StatefulWidget {
  final VoiceService voiceService;

  const _RateSection({required this.voiceService});

  @override
  State<_RateSection> createState() => _RateSectionState();
}

class _RateSectionState extends State<_RateSection> {
  late double _sliderValue;

  @override
  void initState() {
    super.initState();
    _sliderValue = widget.voiceService.speechRate;
  }

  String _labelForRate(double rate) {
    if (rate <= 0.3) return 'Muito Lento';
    if (rate <= 0.4) return 'Lento';
    if (rate <= 0.5) return 'Médio';
    return 'Rápido';
  }

  @override
  Widget build(BuildContext context) {
    final voiceService = widget.voiceService;

    return Container(
      decoration: BoxDecoration(
        color: DesignTokens.colors.surfaceCard,
        borderRadius: DesignTokens.radii.card,
        border: Border.all(color: DesignTokens.colors.borderSoft),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'VELOCIDADE DA FALA',
                style: TextStyle(
                  fontFamily: DesignTokens.fontFamily,
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1,
                  color: DesignTokens.colors.brand,
                ),
              ),
              Text(
                _labelForRate(voiceService.speechRate),
                style: TextStyle(
                  fontFamily: DesignTokens.fontFamily,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: DesignTokens.colors.textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          SliderTheme(
            data: SliderThemeData(
              activeTrackColor: DesignTokens.colors.brand,
              inactiveTrackColor: DesignTokens.colors.brand.withValues(alpha: 0.2),
              thumbColor: DesignTokens.colors.brand,
              overlayColor: DesignTokens.colors.brand.withValues(alpha: 0.12),
              trackHeight: 6,
              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 10),
              overlayShape: const RoundSliderOverlayShape(overlayRadius: 20),
            ),
            child: Slider(
              value: _sliderValue,
              min: 0.25,
              max: 0.55,
              divisions: 3,
              label: _labelForRate(_sliderValue),
              onChanged: (value) {
                setState(() => _sliderValue = value);
              },
              onChangeEnd: (value) {
                voiceService.setSpeechRate(value);
              },
            ),
          ),
          const SizedBox(height: 4),
          Center(
            child: GestureDetector(
              onTap: () => voiceService.previewRate(_sliderValue),
              child: Container(
                height: 52,
                padding: const EdgeInsets.symmetric(horizontal: 24),
                decoration: BoxDecoration(
                  color: DesignTokens.colors.brand.withValues(alpha: 0.06),
                  borderRadius: DesignTokens.radii.button,
                  border: Border.all(
                    color: DesignTokens.colors.brand,
                    width: 2,
                  ),
                ),
                child: Center(
                  child: Text(
                    'Ouvir exemplo',
                    style: TextStyle(
                      fontFamily: DesignTokens.fontFamily,
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                      color: DesignTokens.colors.brand,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Radio26 extends StatelessWidget {
  final bool isSelected;

  const _Radio26({required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
      width: 26,
      height: 26,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isSelected ? DesignTokens.colors.brand : Colors.transparent,
        border: Border.all(
          color: isSelected
              ? DesignTokens.colors.brand
              : DesignTokens.colors.borderSoft.withValues(alpha: 0.7),
          width: 2,
        ),
      ),
      child: isSelected
          ? Center(
              child: Container(
                width: 10,
                height: 10,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
              ),
            )
          : null,
    );
  }
}
