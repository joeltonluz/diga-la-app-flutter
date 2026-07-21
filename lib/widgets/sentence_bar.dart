import 'package:flutter/material.dart';
import '../domain/entities/pictogram_card.dart';
import '../theme/design_tokens.dart';

class SentenceBar extends StatelessWidget {
  final List<PictogramCard> cards;
  final ScrollController? scrollController;
  final bool compact;
  final String? Function(PictogramCard)? labelFor;
  final String emptyMessage;
  final int? speakingIndex;
  final void Function(int index)? onCardTap;
  final void Function(int oldIndex)? onMoveLeft;
  final void Function(int index)? onMoveRight;

  const SentenceBar({
    super.key,
    required this.cards,
    this.scrollController,
    this.compact = false,
    this.labelFor,
    this.emptyMessage = 'Toque nos cartões para montar uma frase',
    this.speakingIndex,
    this.onCardTap,
    this.onMoveLeft,
    this.onMoveRight,
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
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: hasCards
          ? ListView.separated(
              controller: scrollController,
              scrollDirection: Axis.horizontal,
              itemCount: cards.length,
              separatorBuilder: (_, _) =>
                  SizedBox(width: DesignTokens.spacing.xs),
              itemBuilder: (context, index) {
                final card = cards[index];
                return _MiniCard(
                  card: card,
                  compact: compact,
                  label: labelFor?.call(card),
                  isFirst: index == 0,
                  isLast: index == cards.length - 1,
                  isSpeaking: speakingIndex == index,
                  onTap: onCardTap != null
                      ? () => onCardTap!(index)
                      : null,
                  onMoveLeft: onMoveLeft != null && index > 0
                      ? () => onMoveLeft!(index)
                      : null,
                  onMoveRight: onMoveRight != null && index < cards.length - 1
                      ? () => onMoveRight!(index)
                      : null,
                );
              },
            )
          : Center(
              child: Text(
                emptyMessage,
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
  final PictogramCard card;
  final bool compact;
  final String? label;
  final bool isFirst;
  final bool isLast;
  final bool isSpeaking;
  final VoidCallback? onTap;
  final VoidCallback? onMoveLeft;
  final VoidCallback? onMoveRight;

  const _MiniCard({
    required this.card,
    this.compact = false,
    this.label,
    this.isFirst = false,
    this.isLast = false,
    this.isSpeaking = false,
    this.onTap,
    this.onMoveLeft,
    this.onMoveRight,
  });

  @override
  Widget build(BuildContext context) {
    final cardWidth = compact ? 56.0 : 72.0;

    final borderColor = isSpeaking
        ? DesignTokens.colors.brand
        : DesignTokens.colors.borderSoft.withValues(alpha: 0.4);

    final borderWidth = isSpeaking ? 3.0 : 1.0;

    final bgColor = isSpeaking
        ? DesignTokens.colors.brand.withValues(alpha: 0.08)
        : DesignTokens.colors.surfaceCard;

    final arrowCount = (onMoveLeft != null ? 1 : 0) + (onMoveRight != null ? 1 : 0);

    return SizedBox(
      width: cardWidth + (arrowCount * 20),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (onMoveLeft != null)
            GestureDetector(
              onTap: onMoveLeft,
              child: Container(
                width: 20,
                height: 40,
                alignment: Alignment.center,
                child: Icon(
                  Icons.chevron_left,
                  size: compact ? 14 : 16,
                  color: DesignTokens.colors.brand,
                ),
              ),
            ),
          GestureDetector(
            onTap: onTap,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: cardWidth,
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: DesignTokens.radii.mini,
                border: Border.all(
                  color: borderColor,
                  width: borderWidth,
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(card.emoji,
                      style: TextStyle(fontSize: compact ? 18 : 24)),
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
            ),
          ),
          if (onMoveRight != null)
            GestureDetector(
              onTap: onMoveRight,
              child: Container(
                width: 20,
                height: 40,
                alignment: Alignment.center,
                child: Icon(
                  Icons.chevron_right,
                  size: compact ? 14 : 16,
                  color: DesignTokens.colors.brand,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
