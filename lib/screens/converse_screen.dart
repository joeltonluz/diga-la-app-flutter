import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/datasources/sample_cards.dart';
import '../domain/entities/pictogram_card.dart';
import '../presentation/providers/saved_phrases_provider.dart';
import '../presentation/providers/sentence_provider.dart';
import '../providers/language_provider.dart';
import '../providers/pictogram_repository_provider.dart';
import '../theme/design_tokens.dart';
import '../widgets/balo_widget.dart';
import '../widgets/card_tile.dart';
import '../widgets/category_chip_bar.dart';
import '../widgets/sentence_bar.dart';

class ConverseScreen extends ConsumerStatefulWidget {
  const ConverseScreen({super.key});

  @override
  ConsumerState<ConverseScreen> createState() => _ConverseScreenState();
}

class _ConverseScreenState extends ConsumerState<ConverseScreen> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey<BaloWidgetState> _baloKey = GlobalKey<BaloWidgetState>();
  String? _selectedCategoryId;

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _addCard(PictogramCard card) {
    ref.read(sentenceProvider.notifier).addCard(card);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
        );
      }
    });
  }

  Future<void> _speakSentence() async {
    final languageService = ref.read(languageServiceProvider);
    final cards = ref.read(sentenceProvider);

    if (cards.isEmpty) return;

    _baloKey.currentState?.startPulse();

    for (int i = 0; i < cards.length; i++) {
      final isActive = ref.read(speakingIndexProvider) != null;
      if (!isActive && i > 0) break;
      ref.read(speakingIndexProvider.notifier).state = i;
      await languageService.speak(cards[i]);
    }

    ref.read(speakingIndexProvider.notifier).state = null;
  }

  void _stopSpeech() {
    ref.read(speakingIndexProvider.notifier).state = null;
    ref.read(ttsServiceProvider).stop();
  }

  void _clearSentence() => ref.read(sentenceProvider.notifier).clear();

  void _removeLast() => ref.read(sentenceProvider.notifier).removeLast();

  void _removeCardAt(int index) =>
      ref.read(sentenceProvider.notifier).removeAt(index);

  void _moveCardLeft(int index) =>
      ref.read(sentenceProvider.notifier).reorder(index, index - 1);

  void _moveCardRight(int index) =>
      ref.read(sentenceProvider.notifier).reorder(index, index + 1);

  Future<void> _savePhrase() async {
    final cards = ref.read(sentenceProvider);
    if (cards.isEmpty) return;

    final nameController = TextEditingController();
    final name = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(ref.read(languageServiceProvider).translate('savePhrase')),
        content: TextField(
          controller: nameController,
          decoration: InputDecoration(
            hintText: ref
                .read(languageServiceProvider)
                .translate('phraseNameHint'),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(ref.read(languageServiceProvider).translate('cancel')),
          ),
          TextButton(
            onPressed: () => Navigator.pop(
              context,
              nameController.text.isEmpty
                  ? 'Frase Customizada'
                  : nameController.text,
            ),
            child: Text(ref.read(languageServiceProvider).translate('save')),
          ),
        ],
      ),
    );

    if (name == null) return;
    await ref
        .read(savedPhrasesProvider.notifier)
        .save(name.isEmpty ? null : name, cards);
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            ref.read(languageServiceProvider).translate('phraseSaved'),
          ),
        ),
      );
    }
  }

  List<PictogramCard> _getCurrentCards() {
    if (_selectedCategoryId == null) return sampleCards;

    final categories = ref.read(pictogramRepositoryProvider).getAllCategories();
    final category = categories
        .where((c) => c.id == _selectedCategoryId)
        .firstOrNull;
    return category?.items ?? [];
  }

  @override
  Widget build(BuildContext context) {
    final languageService = ref.watch(languageServiceProvider);
    final sentenceCards = ref.watch(sentenceProvider);
    final speakingIndex = ref.watch(speakingIndexProvider);
    final categories = ref
        .watch(pictogramRepositoryProvider)
        .getAllCategories();
    final isSpeaking = speakingIndex != null;
    final hasCards = sentenceCards.isNotEmpty;
    final size = MediaQuery.of(context).size;
    final isLandscape = size.width > size.height;
    final currentCards = _getCurrentCards();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => Navigator.pop(context),
          tooltip: languageService.translate('back'),
        ),
        title: Text(languageService.translate('converse')),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
            child: SizedBox(
              height: hasCards ? 100 : 120,
              child: hasCards
                  ? SentenceBar(
                      cards: sentenceCards,
                      scrollController: _scrollController,
                      compact: isLandscape,
                      labelFor: languageService.labelFor,
                      emptyMessage: languageService.translate('emptySentence'),
                      speakingIndex: speakingIndex,
                      onCardTap: isSpeaking ? null : _removeCardAt,
                      onMoveLeft: isSpeaking ? null : _moveCardLeft,
                      onMoveRight: isSpeaking ? null : _moveCardRight,
                    )
                  : Center(
                      child: BaloWidget(
                        key: _baloKey,
                        size: 84,
                        animation: BaloAnimation.pulse,
                        emptyMessage: languageService.translate(
                          'emptySentence',
                        ),
                      ),
                    ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SizedBox(
              height: 64,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _ActionButton(
                    label: '⌫',
                    fontSize: 22,
                    onTap: hasCards && !isSpeaking ? _removeLast : null,
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    flex: 2,
                    child: isSpeaking
                        ? ElevatedButton(
                            onPressed: _stopSpeech,
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size(double.infinity, 64),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18),
                              ),
                              backgroundColor: const Color(0xFFE57373),
                              foregroundColor: DesignTokens.colors.surfaceCard,
                            ),
                            child: Text(
                              languageService.translate('stop'),
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          )
                        : ElevatedButton(
                            onPressed: hasCards ? _speakSentence : null,
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size(double.infinity, 64),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18),
                              ),
                            ),
                            child: Text(
                              languageService.translate('speak'),
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                  ),
                  const SizedBox(width: 4),
                  _ActionButton(
                    label: languageService.translate('clear'),
                    fontSize: 14,
                    onTap: hasCards && !isSpeaking ? _clearSentence : null,
                  ),
                  const SizedBox(width: 4),
                  _ActionButton(
                    label: '⭐️', //'💾',
                    fontSize: 18,
                    onTap: hasCards && !isSpeaking ? _savePhrase : null,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          CategoryChipBar(
            categories: categories,
            generalCards: sampleCards,
            selectedCategoryId: _selectedCategoryId,
            languageService: languageService,
            onCategorySelected: (id) {
              setState(() => _selectedCategoryId = id);
            },
          ),
          const SizedBox(height: 6),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: GridView.count(
                crossAxisCount: 3,
                mainAxisSpacing: isLandscape ? 10 : 16,
                crossAxisSpacing: isLandscape ? 10 : 16,
                childAspectRatio: isLandscape ? 1.4 : 1.0,
                children: currentCards.map((card) {
                  return CardTile(
                    key: ValueKey('card_${card.id}'),
                    card: card,
                    label: languageService.labelFor(card),
                    onTap: () => _addCard(card),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final String label;
  final double fontSize;
  final VoidCallback? onTap;

  const _ActionButton({
    required this.label,
    required this.fontSize,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isActive = onTap != null;

    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 64,
          decoration: BoxDecoration(
            color: DesignTokens.colors.surfaceCard,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: isActive
                  ? DesignTokens.colors.borderSoft
                  : DesignTokens.colors.borderSoft.withValues(alpha: 0.3),
              width: 2,
            ),
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                fontFamily: DesignTokens.fontFamily,
                fontSize: fontSize,
                fontWeight: FontWeight.w700,
                color: isActive
                    ? DesignTokens.colors.textPrimary
                    : DesignTokens.colors.textSecondary.withValues(alpha: 0.3),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
