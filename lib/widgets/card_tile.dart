import 'package:flutter/material.dart' hide Card;
import '../models/card.dart';

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
    final theme = Theme.of(context);

    return Material(
      color: theme.colorScheme.surface,
      borderRadius: BorderRadius.circular(16),
      elevation: 1,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        splashColor: theme.colorScheme.primary.withValues(alpha: 0.15),
        highlightColor: theme.colorScheme.primary.withValues(alpha: 0.08),
        child: Container(
          constraints: const BoxConstraints(minHeight: 80, minWidth: 80),
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                card.emoji,
                style: const TextStyle(fontSize: 40),
              ),
              const SizedBox(height: 8),
              Text(
                label ?? card.label,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
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
