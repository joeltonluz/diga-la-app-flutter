import 'package:flutter/material.dart' hide Card;
import '../models/category.dart';
import '../services/language_service.dart';
import '../widgets/card_tile.dart';

class CategoryGridScreen extends StatelessWidget {
  final Category category;
  final LanguageService languageService;

  const CategoryGridScreen({
    super.key,
    required this.category,
    required this.languageService,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(category.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 1,
          children: category.items.map((card) {
            return CardTile(
              card: card,
              onTap: () => languageService.speak(card),
            );
          }).toList(),
        ),
      ),
    );
  }
}
