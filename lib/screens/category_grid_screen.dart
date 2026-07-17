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
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(category.name),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.count(
          crossAxisCount: 3,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 1.0,
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
