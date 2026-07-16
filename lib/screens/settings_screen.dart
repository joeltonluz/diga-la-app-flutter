import 'package:flutter/material.dart' hide Card;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/language_provider.dart';
import '../services/language_service.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final languageAsync = ref.watch(languageServiceProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Configurações'),
      ),
      body: languageAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Erro: $e')),
        data: (languageService) {
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Text(
                'Idioma de fala',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              Text(
                'Escolha como o app fala os cartões ao toque.',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context)
                      .colorScheme
                      .onSurface
                      .withValues(alpha: 0.7),
                ),
              ),
              const SizedBox(height: 16),
              _LanguageOption(
                mode: LanguageMode.pt,
                title: 'Só Português',
                description: 'O app fala em português',
                selected: languageService.currentMode == LanguageMode.pt,
                onChanged: (mode) => languageService.setMode(mode),
              ),
              const SizedBox(height: 8),
              _LanguageOption(
                mode: LanguageMode.en,
                title: 'Só Inglês',
                description: 'O app fala em inglês',
                selected: languageService.currentMode == LanguageMode.en,
                onChanged: (mode) => languageService.setMode(mode),
              ),
              const SizedBox(height: 8),
              _LanguageOption(
                mode: LanguageMode.ptEn,
                title: 'Português e Inglês',
                description: 'O app fala os dois, um depois do outro',
                selected: languageService.currentMode == LanguageMode.ptEn,
                onChanged: (mode) => languageService.setMode(mode),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _LanguageOption extends StatelessWidget {
  final LanguageMode mode;
  final String title;
  final String description;
  final bool selected;
  final ValueChanged<LanguageMode> onChanged;

  const _LanguageOption({
    required this.mode,
    required this.title,
    required this.description,
    required this.selected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Material(
      color: selected
          ? theme.colorScheme.primary.withValues(alpha: 0.1)
          : theme.colorScheme.surface,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: () => onChanged(mode),
        borderRadius: BorderRadius.circular(16),
        child: Container(
          constraints: const BoxConstraints(minHeight: 56),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: selected ? theme.colorScheme.primary : Colors.transparent,
                  border: Border.all(
                    color: selected ? theme.colorScheme.primary : theme.colorScheme.onSurface.withValues(alpha: 0.4),
                    width: 2,
                  ),
                ),
                child: selected
                    ? Icon(Icons.check, size: 16, color: theme.colorScheme.onPrimary)
                    : null,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: theme.textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                      ),
                    ),
                  ],
                ),
              ),
              if (selected)
                Icon(Icons.check, color: theme.colorScheme.primary),
            ],
          ),
        ),
      ),
    );
  }
}
