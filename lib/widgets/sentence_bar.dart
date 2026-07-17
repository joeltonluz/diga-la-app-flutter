import 'package:flutter/material.dart' hide Card;
import '../models/card.dart';
import '../theme/design_tokens.dart';

class SentenceBar extends StatelessWidget {
  final List<Card> cards;
  final ScrollController? scrollController;
  final bool compact;
  final String? Function(Card)? labelFor;

  const SentenceBar({
    super.key,
    required this.cards,
    this.scrollController,
    this.compact = false,
    this.labelFor,
  });

  @override
  Widget build(BuildContext context) {
    final hasCards = cards.isNotEmpty;

    return Container(
      width: double.infinity,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: DesignTokens.colors.surfaceCard,
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        border: Border.all(
          color: DesignTokens.colors.borderSoft,
          width: 1,
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: hasCards
          ? ListView.separated(
              controller: scrollController,
              scrollDirection: Axis.horizontal,
              itemCount: cards.length,
              separatorBuilder: (_, _) => SizedBox(width: DesignTokens.spacing.xs),
              itemBuilder: (context, index) {
                final card = cards[index];
                return _MiniCard(
                  card: card,
                  compact: compact,
                  label: labelFor?.call(card),
                );
              },
            )
          : Center(
              child: Text(
                'Toque nos cartões para montar uma frase',
                style: TextStyle(
                  fontFamily: DesignTokens.fontFamily,
                  fontSize: 17,
                  fontWeight: FontWeight.w400,
                  color: DesignTokens.colors.textSecondary,
                ),
              ),
            ),
    );
  }
}

class _MiniCard extends StatelessWidget {
  final Card card;
  final bool compact;
  final String? label;

  const _MiniCard({required this.card, this.compact = false, this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: compact ? 56 : 72,
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: DesignTokens.colors.surfaceCard,
        borderRadius: DesignTokens.radii.mini,
        border: Border.all(
          color: DesignTokens.colors.borderSoft.withValues(alpha: 0.4),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(card.emoji, style: TextStyle(fontSize: compact ? 20 : 26)),
          const SizedBox(height: 2),
          Text(
            label ?? card.label,
            style: DesignTokens.textStyles.caption.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: compact ? 9 : 10,
            ),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ],
      ),
    );
  }
}
