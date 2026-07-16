import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/sample_categories.dart';
import '../providers/language_provider.dart';
import 'category_grid_screen.dart';

class LearnScreen extends ConsumerWidget {
  const LearnScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final languageService = ref.watch(languageServiceProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Modo Aprender'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 1.2,
          children: sampleCategories.map((category) {
            return Material(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(16),
              elevation: 1,
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
                borderRadius: BorderRadius.circular(16),
                child: Container(
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
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
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
        ),
      ),
    );
  }
}
