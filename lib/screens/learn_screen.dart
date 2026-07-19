import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/datasources/sample_categories.dart';
import '../providers/language_provider.dart';
import '../services/language_service.dart';
import '../theme/design_tokens.dart';
import 'category_grid_screen.dart';

class LearnScreen extends ConsumerWidget {
  const LearnScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final languageService = ref.watch(languageServiceProvider);
    final appMode = languageService.appMode;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(languageService.translate('learn')),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
          childAspectRatio: 1.2,
          children: sampleCategories.map((category) {
            final categoryName = appMode == LanguageMode.en ? category.nameEn : category.name;
            return Ink(
              decoration: BoxDecoration(
                color: DesignTokens.colors.surfaceCard,
                borderRadius: DesignTokens.radii.card,
                boxShadow: DesignTokens.shadows.card,
              ),
              child: InkWell(
                borderRadius: DesignTokens.radii.card,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => CategoryGridScreen(
                        category: category,
                      ),
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        category.icon,
                        style: const TextStyle(fontSize: 40),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        categoryName,
                        style: TextStyle(
                          fontFamily: DesignTokens.fontFamily,
                          fontSize: 19,
                          fontWeight: FontWeight.w700,
                          color: DesignTokens.colors.textPrimary,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
