import 'card.dart';

class Category {
  final String id;
  final String name;
  final String icon;
  final List<Card> items;

  const Category({
    required this.id,
    required this.name,
    required this.icon,
    required this.items,
  });
}
