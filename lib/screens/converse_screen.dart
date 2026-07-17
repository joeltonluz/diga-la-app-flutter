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
    final cards = _sentenceCards.toList();
    for (final card in cards) {
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
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
            child: SizedBox(
              height: 100,
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
              height: 64,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _ActionButton(
                    label: '⌫',
                    fontSize: 22,
                    onTap: hasCards ? _removeLast : null,
                    flex: 1,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    flex: 2,
                    child: ElevatedButton(
                      onPressed: hasCards ? _speakSentence : null,
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 64),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                      ),
                      child: const Text(
                        'Falar',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  _ActionButton(
                    label: 'Limpar',
                    fontSize: 16,
                    onTap: hasCards ? _clearSentence : null,
                    flex: 1,
                  ),
                ],
              ),
            ),
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

class _ActionButton extends StatelessWidget {
  final String label;
  final double fontSize;
  final VoidCallback? onTap;
  final int flex;

  const _ActionButton({
    required this.label,
    required this.fontSize,
    required this.onTap,
    this.flex = 1,
  });

  @override
  Widget build(BuildContext context) {
    final isActive = onTap != null;

    return Expanded(
      flex: flex,
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
