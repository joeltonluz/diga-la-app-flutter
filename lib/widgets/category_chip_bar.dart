import 'package:flutter/material.dart';

import '../domain/entities/category.dart';
import '../domain/entities/pictogram_card.dart';
import '../services/language_service.dart';
import '../theme/design_tokens.dart';

class CategoryChipBar extends StatelessWidget {
  final List<Category> categories;
  final List<PictogramCard> generalCards;
  final String? selectedCategoryId;
  final LanguageService languageService;
  final ValueChanged<String?> onCategorySelected;

  const CategoryChipBar({
    super.key,
    required this.categories,
    required this.generalCards,
    required this.selectedCategoryId,
    required this.languageService,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    final isGeneralSelected = selectedCategoryId == null;

    return SizedBox(
      height: 48,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: categories.length + 1,
        separatorBuilder: (_, _) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          if (index == 0) {
            final selected = isGeneralSelected;
            return _Chip(
              emoji: '📋',
              label: languageService.translate('general'),
              selected: selected,
              onTap: () => onCategorySelected(null),
            );
          }

          final category = categories[index - 1];
          final selected = selectedCategoryId == category.id;
          final label = languageService.appMode == LanguageMode.en
              ? category.nameEn
              : category.name;

          return _Chip(
            emoji: category.icon,
            label: label,
            selected: selected,
            onTap: () => onCategorySelected(category.id),
          );
        },
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  final String emoji;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _Chip({
    required this.emoji,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: selected
              ? DesignTokens.colors.brand
              : DesignTokens.colors.surfaceCard,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: selected
                ? DesignTokens.colors.brand
                : DesignTokens.colors.borderSoft,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(emoji, style: const TextStyle(fontSize: 18)),
            const SizedBox(width: 6),
            Text(
              label,
              style: DesignTokens.textStyles.bodySmall.copyWith(
                color: selected
                    ? DesignTokens.colors.surfaceCard
                    : DesignTokens.colors.textPrimary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
