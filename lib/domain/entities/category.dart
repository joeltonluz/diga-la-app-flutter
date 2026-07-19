import 'pictogram_card.dart';

class Category {
  final String id;
  final String name;
  final String icon;
  final List<PictogramCard> items;

  const Category({
    required this.id,
    required this.name,
    required this.icon,
    required this.items,
  });
}
