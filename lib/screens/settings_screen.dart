import 'package:flutter/material.dart' hide Card;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/voice.dart';
import '../providers/language_provider.dart';
import '../providers/voice_provider.dart';
import '../services/language_service.dart';

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
        title: const Text('Configurações'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        children: [
          _LanguageHeader(),
          const SizedBox(height: 24),
          _ModeCard(
            mode: LanguageMode.pt,
            flag: '🇧🇷',
            title: 'Português',
            description: 'Fala os cartões em português do Brasil',
            isSelected: current == LanguageMode.pt,
            onTap: () => languageService.setMode(LanguageMode.pt),
          ),
          const SizedBox(height: 12),
          _ModeCard(
            mode: LanguageMode.en,
            flag: '🇺🇸',
            title: 'English',
            description: 'Speaks cards in American English',
            isSelected: current == LanguageMode.en,
            onTap: () => languageService.setMode(LanguageMode.en),
          ),
          const SizedBox(height: 32),
          _VoiceSection(
            voices: voices,
            selectedVoice: selectedVoice,
            onSelect: (voice) => voiceService.selectVoice(voice),
            onPreview: (voice) => voiceService.previewVoice(voice),
          ),
          const SizedBox(height: 32),
          _RateSection(
            currentRate: voiceService.speechRate,
            onSelect: (rate) => voiceService.setSpeechRate(rate),
            onPreview: (rate) => voiceService.previewRate(rate),
          ),
        ],
      ),
    );
  }
}

class _LanguageHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Idioma de fala',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Escolha como o app fala em voz alta os cartões que você tocar.',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
            height: 1.4,
          ),
        ),
      ],
    );
  }
}

class _VoiceSection extends StatelessWidget {
  final List<Voice> voices;
  final Voice? selectedVoice;
  final ValueChanged<Voice> onSelect;
  final ValueChanged<Voice> onPreview;

  const _VoiceSection({
    required this.voices,
    required this.selectedVoice,
    required this.onSelect,
    required this.onPreview,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Voz',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Escolha a voz que o app usa para falar.',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
            height: 1.4,
          ),
        ),
        const SizedBox(height: 16),
        if (voices.isEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Text(
              'Nenhuma voz disponível para este idioma.',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.4),
              ),
            ),
          )
        else
          ...voices.map(
            (voice) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: _VoiceCard(
                voice: voice,
                isSelected: selectedVoice?.name == voice.name,
                onTap: () => onSelect(voice),
                onPlay: () => onPreview(voice),
              ),
            ),
          ),
      ],
    );
  }
}

class _VoiceCard extends StatelessWidget {
  final Voice voice;
  final bool isSelected;
  final VoidCallback onTap;
  final VoidCallback onPlay;

  const _VoiceCard({
    required this.voice,
    required this.isSelected,
    required this.onTap,
    required this.onPlay,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = isSelected
        ? theme.colorScheme.primary
        : theme.colorScheme.outline.withValues(alpha: 0.3);

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          color: isSelected
              ? theme.colorScheme.primary.withValues(alpha: 0.08)
              : theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: color,
            width: isSelected ? 2 : 1.5,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
          child: Row(
            children: [
              Icon(
                Icons.record_voice_over_rounded,
                size: 28,
                color: isSelected
                    ? theme.colorScheme.primary
                    : theme.colorScheme.onSurface.withValues(alpha: 0.5),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  voice.name,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                  ),
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.play_circle_outline_rounded,
                  color: theme.colorScheme.primary,
                  size: 28,
                ),
                onPressed: onPlay,
                tooltip: 'Ouvir',
              ),
              const SizedBox(width: 4),
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeInOut,
                width: 26,
                height: 26,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isSelected ? theme.colorScheme.primary : Colors.transparent,
                  border: Border.all(
                    color: isSelected ? theme.colorScheme.primary : theme.colorScheme.outline.withValues(alpha: 0.4),
                    width: 2,
                  ),
                ),
                child: isSelected
                    ? Icon(Icons.check, size: 16, color: theme.colorScheme.onPrimary)
                    : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

const _rateLevels = [
  ('Muito Lento', 'Muito lento, para crianças que precisam de bastante tempo', 0.25),
  ('Lento', 'Lento e claro, bom para o dia a dia', 0.35),
  ('Médio', 'Velocidade mediana, para quem já está acostumado', 0.45),
  ('Rápido', 'Rápido, para conversas mais ágeis', 0.55),
];

class _RateSection extends StatelessWidget {
  final double currentRate;
  final ValueChanged<double> onSelect;
  final ValueChanged<double> onPreview;

  const _RateSection({
    required this.currentRate,
    required this.onSelect,
    required this.onPreview,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Velocidade',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Escolha a velocidade da fala.',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
            height: 1.4,
          ),
        ),
        const SizedBox(height: 16),
        for (final (name, desc, rate) in _rateLevels)
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: _RateCard(
              name: name,
              description: desc,
              rate: rate,
              isSelected: currentRate == rate,
              onTap: () => onSelect(rate),
              onPlay: () => onPreview(rate),
            ),
          ),
      ],
    );
  }
}

class _RateCard extends StatelessWidget {
  final String name;
  final String description;
  final double rate;
  final bool isSelected;
  final VoidCallback onTap;
  final VoidCallback onPlay;

  const _RateCard({
    required this.name,
    required this.description,
    required this.rate,
    required this.isSelected,
    required this.onTap,
    required this.onPlay,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = isSelected
        ? theme.colorScheme.primary
        : theme.colorScheme.outline.withValues(alpha: 0.3);

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          color: isSelected
              ? theme.colorScheme.primary.withValues(alpha: 0.08)
              : theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: color,
            width: isSelected ? 2 : 1.5,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
          child: Row(
            children: [
              Icon(
                Icons.speed_rounded,
                size: 28,
                color: isSelected
                    ? theme.colorScheme.primary
                    : theme.colorScheme.onSurface.withValues(alpha: 0.5),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: theme.textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 17,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      description,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurface.withValues(alpha: 0.55),
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.play_circle_outline_rounded,
                  color: theme.colorScheme.primary,
                  size: 28,
                ),
                onPressed: onPlay,
                tooltip: 'Ouvir',
              ),
              const SizedBox(width: 4),
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeInOut,
                width: 26,
                height: 26,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isSelected ? theme.colorScheme.primary : Colors.transparent,
                  border: Border.all(
                    color: isSelected ? theme.colorScheme.primary : theme.colorScheme.outline.withValues(alpha: 0.4),
                    width: 2,
                  ),
                ),
                child: isSelected
                    ? Icon(Icons.check, size: 16, color: theme.colorScheme.onPrimary)
                    : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ModeCard extends StatelessWidget {
  final LanguageMode mode;
  final String flag;
  final String title;
  final String description;
  final bool isSelected;
  final VoidCallback onTap;

  const _ModeCard({
    required this.mode,
    required this.flag,
    required this.title,
    required this.description,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = isSelected ? theme.colorScheme.primary : theme.colorScheme.outline.withValues(alpha: 0.3);

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          color: isSelected
              ? theme.colorScheme.primary.withValues(alpha: 0.08)
              : theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: color,
            width: isSelected ? 2 : 1.5,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
          child: Row(
            children: [
              SizedBox(
                width: 48,
                height: 48,
                child: Center(
                  child: Text(flag, style: const TextStyle(fontSize: 34)),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: theme.textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 17,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurface.withValues(alpha: 0.55),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeInOut,
                width: 26,
                height: 26,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isSelected ? theme.colorScheme.primary : Colors.transparent,
                  border: Border.all(
                    color: isSelected ? theme.colorScheme.primary : theme.colorScheme.outline.withValues(alpha: 0.4),
                    width: 2,
                  ),
                ),
                child: isSelected
                    ? Icon(Icons.check, size: 16, color: theme.colorScheme.onPrimary)
                    : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
