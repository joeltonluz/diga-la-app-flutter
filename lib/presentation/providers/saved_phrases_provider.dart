import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/entities/pictogram_card.dart';
import '../../domain/entities/saved_phrase.dart';
import '../../domain/repositories/pictogram_repository.dart';
import '../../providers/pictogram_repository_provider.dart';

const _storageKey = 'saved_phrases';

class SavedPhrasesNotifier extends StateNotifier<List<SavedPhrase>> {
  final PictogramRepository _pictogramRepository;

  SavedPhrasesNotifier(this._pictogramRepository) : super([]);

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_storageKey);
    if (raw == null) return;

    final list = (jsonDecode(raw) as List)
        .map((e) => SavedPhrase.fromJson(e as Map<String, dynamic>))
        .toList();
    state = list;
  }

  Future<void> save(String? name, List<PictogramCard> cards) async {
    final cardIds = cards.map((c) => c.id).toList();

    final existingIndex = state.indexWhere((p) =>
        p.cardIds.length == cardIds.length &&
        p.cardIds.asMap().entries.every((e) => e.value == cardIds[e.key]));

    if (existingIndex >= 0) {
      state = [
        for (int i = 0; i < state.length; i++)
          if (i == existingIndex)
            state[i].copyWith(name: name, createdAt: DateTime.now())
          else
            state[i],
      ];
    } else {
      state = [
        ...state,
        SavedPhrase(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          name: name,
          cardIds: cardIds,
          createdAt: DateTime.now(),
        ),
      ];
    }
    await _persist();
  }

  Future<void> delete(String id) async {
    state = state.where((p) => p.id != id).toList();
    await _persist();
  }

  List<PictogramCard> loadInto(String id) {
    final phrase = state.firstWhere((p) => p.id == id);
    return phrase.cardIds
        .map((cardId) => _pictogramRepository.getAllCards().firstWhere(
              (c) => c.id == cardId,
            ))
        .toList();
  }

  Future<void> _persist() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = jsonEncode(state.map((p) => p.toJson()).toList());
    await prefs.setString(_storageKey, raw);
  }
}

final savedPhrasesProvider =
    StateNotifierProvider<SavedPhrasesNotifier, List<SavedPhrase>>((ref) {
  final repository = ref.read(pictogramRepositoryProvider);
  return SavedPhrasesNotifier(repository);
});
