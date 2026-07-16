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
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return Scaffold(
      appBar: AppBar(
        title: Text(category.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final cellRatio = isLandscape ? 1.4 : 1.0;
            return GridView.count(
              crossAxisCount: isLandscape ? 3 : 2,
              mainAxisSpacing: isLandscape ? 10 : 16,
              crossAxisSpacing: isLandscape ? 10 : 16,
              childAspectRatio: cellRatio,
              children: category.items.map((card) {
                return CardTile(
                  card: card,
                  label: languageService.labelFor(card),
                  onTap: () => languageService.speak(card),
                );
              }).toList(),
            );
          },
        ),
      ),
    );
  }
}
