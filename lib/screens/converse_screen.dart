import 'package:flutter/material.dart' hide Card;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/sample_cards.dart';
import '../providers/language_provider.dart';
import '../widgets/card_tile.dart';

class ConverseScreen extends ConsumerWidget {
  const ConverseScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final languageAsync = ref.watch(languageServiceProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Modo Conversar'),
      ),
      body: languageAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Erro: $e')),
        data: (languageService) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: GridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 1,
              children: sampleCards.map((card) {
                return CardTile(
                  card: card,
                  onTap: () => languageService.speak(card),
                );
              }).toList(),
            ),
          );
        },
      ),
    );
  }
}
