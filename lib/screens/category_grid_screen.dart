import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/entities/category.dart';
import '../providers/language_provider.dart';
import '../services/language_service.dart';
import '../widgets/card_tile.dart';

class CategoryGridScreen extends ConsumerWidget {
  final Category category;

  const CategoryGridScreen({
    super.key,
    required this.category,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final languageService = ref.watch(languageServiceProvider);
    final appMode = languageService.appMode;
    final categoryName = appMode == LanguageMode.en ? category.nameEn : category.name;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(categoryName),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.count(
          crossAxisCount: 3,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          children: category.items.map((card) {
            return CardTile(
              card: card,
              label: languageService.labelFor(card),
              onTap: () => languageService.speak(card),
            );
          }).toList(),
        ),
      ),
    );
  }
}
