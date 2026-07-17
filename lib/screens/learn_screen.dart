import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/sample_categories.dart';
import '../providers/language_provider.dart';
import '../theme/design_tokens.dart';
import 'category_grid_screen.dart';

class LearnScreen extends ConsumerWidget {
  const LearnScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final languageService = ref.watch(languageServiceProvider);
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Modo Aprender'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final cellRatio = isLandscape ? 1.4 : 1.2;
            return GridView.count(
              crossAxisCount: isLandscape ? 3 : 2,
              mainAxisSpacing: isLandscape ? 10 : 16,
              crossAxisSpacing: isLandscape ? 10 : 16,
              childAspectRatio: cellRatio,
              children: sampleCategories.map((category) {
                return Material(
                  color: DesignTokens.colors.surfaceCard,
                  borderRadius: DesignTokens.radii.card,
                  elevation: 0,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => CategoryGridScreen(
                            category: category,
                            languageService: languageService,
                          ),
                        ),
                      );
                    },
                    borderRadius: DesignTokens.radii.card,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: DesignTokens.radii.card,
                        boxShadow: DesignTokens.shadows.card,
                      ),
                      constraints: const BoxConstraints(minHeight: 80),
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            category.icon,
                            style: const TextStyle(fontSize: 40),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            category.name,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.w500,
                                ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            );
          },
        ),
      ),
    );
  }
}
