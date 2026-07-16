import 'package:flutter/material.dart' hide Card;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/sample_cards.dart';
import '../models/card.dart';
import '../providers/language_provider.dart';
import '../widgets/card_tile.dart';
import '../widgets/sentence_bar.dart';

class ConverseScreen extends ConsumerStatefulWidget {
  const ConverseScreen({super.key});

  @override
  ConsumerState<ConverseScreen> createState() => _ConverseScreenState();
}

class _ConverseScreenState extends ConsumerState<ConverseScreen> {
  final List<Card> _sentenceCards = [];
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _addCard(Card card) {
    setState(() => _sentenceCards.add(card));
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

  void _speakSentence() async {
    final languageService = ref.read(languageServiceProvider);
    for (final card in _sentenceCards) {
      await languageService.speak(card);
    }
  }

  void _clearSentence() => setState(() => _sentenceCards.clear());

  void _removeLast() => setState(() => _sentenceCards.removeLast());

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final hasCards = _sentenceCards.isNotEmpty;
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Modo Conversar'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: SentenceBar(
              cards: _sentenceCards,
              scrollController: _scrollController,
              compact: isLandscape,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SizedBox(
              height: 52,
              child: Row(
                children: [
                  _SecondaryButton(
                    icon: Icons.backspace_rounded,
                    onTap: hasCards ? _removeLast : null,
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: hasCards ? _speakSentence : null,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: hasCards ? 52 : 44,
                      height: hasCards ? 52 : 44,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: hasCards
                            ? theme.colorScheme.primary
                            : theme.colorScheme.surfaceContainerHighest,
                        boxShadow: hasCards
                            ? [
                                BoxShadow(
                                  color: theme.colorScheme.primary.withValues(alpha: 0.3),
                                  blurRadius: 12,
                                  offset: const Offset(0, 4),
                                ),
                              ]
                            : null,
                      ),
                      child: Icon(
                        Icons.play_arrow_rounded,
                        size: hasCards ? 30 : 24,
                        color: hasCards
                            ? theme.colorScheme.onPrimary
                            : theme.colorScheme.onSurface.withValues(alpha: 0.3),
                      ),
                    ),
                  ),
                  const Spacer(),
                  _SecondaryButton(
                    icon: Icons.delete_rounded,
                    onTap: hasCards ? _clearSentence : null,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 6),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final cellRatio = isLandscape ? 1.4 : 1.0;
                  return GridView.count(
                    crossAxisCount: 2,
                    mainAxisSpacing: isLandscape ? 10 : 16,
                    crossAxisSpacing: isLandscape ? 10 : 16,
                    childAspectRatio: cellRatio,
                    children: sampleCards.map((card) {
                      return CardTile(
                        card: card,
                        onTap: () => _addCard(card),
                      );
                    }).toList(),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SecondaryButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;

  const _SecondaryButton({
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isActive = onTap != null;

    return Material(
      color: isActive
          ? theme.colorScheme.surfaceContainerHighest
          : Colors.transparent,
      shape: const CircleBorder(),
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: SizedBox(
          width: 44,
          height: 44,
          child: Icon(
            icon,
            size: 22,
            color: isActive
                ? theme.colorScheme.onSurface
                : theme.colorScheme.onSurface.withValues(alpha: 0.15),
          ),
        ),
      ),
    );
  }
}
