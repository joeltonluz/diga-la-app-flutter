import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/entities/saved_phrase.dart';
import '../presentation/providers/saved_phrases_provider.dart';
import '../presentation/providers/sentence_provider.dart';
import '../providers/language_provider.dart';
import '../theme/design_tokens.dart';

class SavedPhrasesScreen extends ConsumerStatefulWidget {
  const SavedPhrasesScreen({super.key});

  @override
  ConsumerState<SavedPhrasesScreen> createState() =>
      _SavedPhrasesScreenState();
}

class _SavedPhrasesScreenState extends ConsumerState<SavedPhrasesScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => ref.read(savedPhrasesProvider.notifier).load(),
    );
  }

  void _loadPhrase(SavedPhrase phrase) {
    final cards = ref.read(savedPhrasesProvider.notifier).loadInto(phrase.id);
    final notifier = ref.read(sentenceProvider.notifier);
    notifier.clear();
    for (final card in cards) {
      notifier.addCard(card);
    }
    Navigator.pushReplacementNamed(context, '/converse');
  }

  Future<void> _deletePhrase(SavedPhrase phrase) async {
    final languageService = ref.read(languageServiceProvider);
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(languageService.translate('deleteConfirm')),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(languageService.translate('cancel')),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(languageService.translate('confirm')),
          ),
        ],
      ),
    );

    if (confirm == true) {
      await ref.read(savedPhrasesProvider.notifier).delete(phrase.id);
    }
  }

  String _phraseLabel(SavedPhrase phrase, String language) {
    if (phrase.name != null && phrase.name!.isNotEmpty) return phrase.name!;
    final words = phrase.cardIds.take(3).join(', ');
    return words;
  }

  @override
  Widget build(BuildContext context) {
    final languageService = ref.watch(languageServiceProvider);
    final phrases = ref.watch(savedPhrasesProvider);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => Navigator.pop(context),
          tooltip: languageService.translate('back'),
        ),
        title: Text(languageService.translate('savedPhrases')),
        centerTitle: true,
      ),
      body: phrases.isEmpty
          ? Center(
              child: Text(
                languageService.translate('noSavedPhrases'),
                style: DesignTokens.textStyles.bodyLarge.copyWith(
                  color: DesignTokens.colors.textSecondary,
                ),
              ),
            )
          : ListView.separated(
              padding: const EdgeInsets.all(20),
              itemCount: phrases.length,
              separatorBuilder: (_, _) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final phrase = phrases[index];
                return Material(
                  color: DesignTokens.colors.surfaceCard,
                  borderRadius: DesignTokens.radii.card,
                  child: InkWell(
                    borderRadius: DesignTokens.radii.card,
                    onTap: () => _loadPhrase(phrase),
                    onLongPress: () => _deletePhrase(phrase),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _phraseLabel(phrase, ''),
                                  style:
                                      DesignTokens.textStyles.bodyLarge,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  phrase.cardIds.length.toString(),
                                  style: DesignTokens.textStyles.caption
                                      .copyWith(
                                    color: DesignTokens.colors.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Icon(
                            Icons.chevron_right_rounded,
                            color: DesignTokens.colors.textSecondary,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
