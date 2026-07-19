import '../../domain/entities/category.dart';
import '../../domain/entities/pictogram_card.dart';
import '../../domain/repositories/pictogram_repository.dart';
import '../datasources/sample_cards.dart';
import '../datasources/sample_categories.dart';

class PictogramRepositoryImpl implements PictogramRepository {
  @override
  List<PictogramCard> getAllCards() => sampleCards;

  @override
  List<Category> getAllCategories() => sampleCategories;

  @override
  Category? getCategoryById(String id) {
    try {
      return sampleCategories.firstWhere((c) => c.id == id);
    } catch (_) {
      return null;
    }
  }
}
