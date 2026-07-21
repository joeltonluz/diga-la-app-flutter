import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:diga_la_app/domain/entities/category.dart';
import 'package:diga_la_app/domain/entities/pictogram_card.dart';
import 'package:diga_la_app/domain/entities/saved_phrase.dart';
import 'package:diga_la_app/domain/repositories/pictogram_repository.dart';
import 'package:diga_la_app/presentation/providers/saved_phrases_provider.dart';

class _MockPictogramRepository extends PictogramRepository {
  @override
  List<PictogramCard> getAllCards() {
    return const [
      PictogramCard(id: 'a', labelPt: 'água', labelEn: 'water', emoji: '💧'),
      PictogramCard(id: 'b', labelPt: 'bola', labelEn: 'ball', emoji: '⚽'),
    ];
  }

  @override
  List<Category> getAllCategories() => [];

  @override
  Category? getCategoryById(String id) => null;
}

void main() {
  late _MockPictogramRepository repository;
  late SavedPhrasesNotifier notifier;

  setUp(() {
    SharedPreferences.setMockInitialValues({});
    repository = _MockPictogramRepository();
    notifier = SavedPhrasesNotifier(repository);
  });

  group('SavedPhrasesNotifier', () {
    test('initial state is empty', () {
      expect(notifier.state, isEmpty);
    });

    test('save adds phrase to state', () async {
      const cards = [
        PictogramCard(id: 'a', labelPt: 'água', labelEn: 'water', emoji: '💧'),
      ];
      await notifier.save('my phrase', cards);

      expect(notifier.state.length, equals(1));
      expect(notifier.state.first.name, equals('my phrase'));
      expect(notifier.state.first.cardIds, equals(['a']));
    });

    test('save without name works', () async {
      const cards = [
        PictogramCard(id: 'a', labelPt: 'água', labelEn: 'water', emoji: '💧'),
      ];
      await notifier.save(null, cards);

      expect(notifier.state.length, equals(1));
      expect(notifier.state.first.name, isNull);
    });

    test('delete removes phrase from state', () async {
      const cards = [
        PictogramCard(id: 'a', labelPt: 'água', labelEn: 'water', emoji: '💧'),
      ];
      await notifier.save('test', cards);
      final id = notifier.state.first.id;

      await notifier.delete(id);

      expect(notifier.state, isEmpty);
    });

    test('load persists and restores phrases', () async {
      const cards = [
        PictogramCard(id: 'a', labelPt: 'água', labelEn: 'water', emoji: '💧'),
      ];

      await notifier.save('saved phrase', cards);
      final firstState = notifier.state;

      final notifier2 = SavedPhrasesNotifier(repository);
      await notifier2.load();

      expect(notifier2.state.length, equals(firstState.length));
      expect(notifier2.state.first.name, equals('saved phrase'));
      expect(notifier2.state.first.cardIds, equals(['a']));
    });

    test('loadInto returns cards from repository', () async {
      const cards = [
        PictogramCard(id: 'a', labelPt: 'água', labelEn: 'water', emoji: '💧'),
      ];

      await notifier.save('test', cards);
      final id = notifier.state.first.id;

      final loaded = notifier.loadInto(id);

      expect(loaded.length, equals(1));
      expect(loaded.first.id, equals('a'));
    });

    test('SavedPhrase model serializes and deserializes', () {
      final original = SavedPhrase(
        id: '123',
        name: 'test',
        cardIds: ['a', 'b'],
        createdAt: DateTime(2026),
      );

      final json = original.toJson();
      final restored = SavedPhrase.fromJson(json);

      expect(restored.id, equals('123'));
      expect(restored.name, equals('test'));
      expect(restored.cardIds, equals(['a', 'b']));
      expect(restored.createdAt, equals(DateTime(2026)));
    });

    test('SavedPhrase model serializes without name', () {
      final original = SavedPhrase(
        id: '456',
        cardIds: ['a'],
        createdAt: DateTime(2026),
      );

      final json = original.toJson();
      final restored = SavedPhrase.fromJson(json);

      expect(restored.name, isNull);
    });
  });
}
