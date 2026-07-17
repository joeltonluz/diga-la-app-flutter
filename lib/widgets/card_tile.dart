import 'package:flutter/material.dart' hide Card;
import '../models/card.dart';
import '../theme/design_tokens.dart';

class CardTile extends StatelessWidget {
  final Card card;
  final VoidCallback onTap;
  final String? label;

  const CardTile({
    super.key,
    required this.card,
    required this.onTap,
    this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: DesignTokens.colors.surfaceCard,
      borderRadius: DesignTokens.radii.card,
      child: InkWell(
        onTap: onTap,
        borderRadius: DesignTokens.radii.card,
        splashColor: DesignTokens.colors.brand.withValues(alpha: 0.15),
        highlightColor: DesignTokens.colors.brand.withValues(alpha: 0.08),
        child: Container(
          constraints: const BoxConstraints(minHeight: 80, minWidth: 80),
          decoration: BoxDecoration(
            borderRadius: DesignTokens.radii.card,
            boxShadow: DesignTokens.shadows.card,
          ),
          padding: EdgeInsets.all(DesignTokens.spacing.sm),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                card.emoji,
                style: const TextStyle(fontSize: 40),
              ),
              SizedBox(height: DesignTokens.spacing.xs),
              Text(
                label ?? card.label,
                style: DesignTokens.textStyles.cardLabel,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
