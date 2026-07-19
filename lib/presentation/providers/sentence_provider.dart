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

  void clear() {
    state = [];
  }
}

final sentenceProvider =
    StateNotifierProvider<SentenceNotifier, List<PictogramCard>>((ref) {
  return SentenceNotifier();
});
