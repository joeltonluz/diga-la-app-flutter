import 'package:flutter/material.dart' hide Card;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/sample_cards.dart';
import '../models/card.dart';
import '../providers/language_provider.dart';
import '../theme/design_tokens.dart';
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
    final languageService = ref.watch(languageServiceProvider);
    final hasCards = _sentenceCards.isNotEmpty;
    final size = MediaQuery.of(context).size;
    final isLandscape = size.width > size.height;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => Navigator.pop(context),
          tooltip: 'Voltar',
        ),
        title: const Text('Conversar'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: SizedBox(
              height: isLandscape ? 80 : 104,
              child: SentenceBar(
                cards: _sentenceCards,
                scrollController: _scrollController,
                compact: isLandscape,
                labelFor: languageService.labelFor,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SizedBox(
              height: 56,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _SecondaryButton(
                    icon: Icons.backspace_rounded,
                    onTap: hasCards ? _removeLast : null,
                  ),
                  ElevatedButton.icon(
                    onPressed: hasCards ? _speakSentence : null,
                    icon: const Icon(Icons.play_arrow_rounded),
                    label: const Text('Falar'),
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(120, 48),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                    ),
                  ),
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
              child: GridView.count(
                crossAxisCount: 3,
                mainAxisSpacing: isLandscape ? 10 : 16,
                crossAxisSpacing: isLandscape ? 10 : 16,
                childAspectRatio: isLandscape ? 1.4 : 1.0,
                children: sampleCards.map((card) {
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

class _SecondaryButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;

  const _SecondaryButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final isActive = onTap != null;

    return Material(
      color: isActive
          ? DesignTokens.colors.borderSoft.withValues(alpha: 0.3)
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
                ? DesignTokens.colors.textPrimary
                : DesignTokens.colors.textSecondary.withValues(alpha: 0.3),
          ),
        ),
      ),
    );
  }
}
