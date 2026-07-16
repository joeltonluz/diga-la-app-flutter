import 'package:flutter/material.dart' hide Card;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/language_provider.dart';
import '../services/language_service.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final languageService = ref.watch(languageServiceProvider);
    final current = languageService.currentMode;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Configurações'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        children: [
          _Header(),
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
          const SizedBox(height: 12),
          _ModeCard(
            mode: LanguageMode.ptEn,
            flag: '🌐',
            title: 'Português + English',
            description: 'Fala os dois idiomas em sequência',
            isSelected: current == LanguageMode.ptEn,
            onTap: () => languageService.setMode(LanguageMode.ptEn),
          ),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
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
