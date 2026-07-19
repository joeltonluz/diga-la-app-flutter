import '../entities/category.dart';
import '../entities/pictogram_card.dart';

abstract class PictogramRepository {
  List<PictogramCard> getAllCards();
  List<Category> getAllCategories();
  Category? getCategoryById(String id);
}
