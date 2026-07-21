import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/pictogram_card.dart';

class SentenceNotifier extends StateNotifier<List<PictogramCard>> {
  SentenceNotifier() : super([]);

  void addCard(PictogramCard card) {
    state = [...state, card];
  }

  void removeLast() {
    if (state.isNotEmpty) {
      state = [...state]..removeLast();
    }
  }

  void removeAt(int index) {
    if (index >= 0 && index < state.length) {
      state = [...state]..removeAt(index);
    }
  }

  void reorder(int oldIndex, int newIndex) {
    if (oldIndex < 0 ||
        oldIndex >= state.length ||
        newIndex < 0 ||
        newIndex >= state.length) {
      return;
    }
    final cards = [...state];
    final card = cards.removeAt(oldIndex);
    cards.insert(newIndex, card);
    state = cards;
  }

  void clear() {
    state = [];
  }
}

final sentenceProvider =
    StateNotifierProvider<SentenceNotifier, List<PictogramCard>>((ref) {
  return SentenceNotifier();
});

final speakingIndexProvider = StateProvider<int?>((ref) => null);
