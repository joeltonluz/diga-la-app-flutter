import 'package:flutter/material.dart' hide Card;
import '../models/card.dart';

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
    final theme = Theme.of(context);
    final hasCards = cards.isNotEmpty;
    final barHeight = compact ? 80.0 : 104.0;

    return Container(
      height: barHeight,
      width: double.infinity,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.45),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: hasCards
              ? theme.colorScheme.primary.withValues(alpha: 0.25)
              : theme.colorScheme.outline.withValues(alpha: 0.1),
          width: hasCards ? 1.5 : 1,
        ),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 12,
        vertical: compact ? 6 : 10,
      ),
      child: hasCards
          ? ListView.separated(
              controller: scrollController,
              scrollDirection: Axis.horizontal,
              itemCount: cards.length,
              separatorBuilder: (_, _) => const SizedBox(width: 6),
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
                'Toque nos cartões para montar sua frase',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.35),
                  fontSize: compact ? 12 : 13,
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
    final theme = Theme.of(context);

    return Container(
      width: compact ? 56 : 72,
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: theme.colorScheme.outline.withValues(alpha: 0.12),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(card.emoji, style: TextStyle(fontSize: compact ? 20 : 26)),
          const SizedBox(height: 2),
          Text(
            label ?? card.label,
            style: theme.textTheme.labelSmall?.copyWith(
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
