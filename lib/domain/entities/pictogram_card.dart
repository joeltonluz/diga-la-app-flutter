class PictogramCard {
  final String id;
  final String labelPt;
  final String labelEn;
  final String emoji;

  const PictogramCard({
    required this.id,
    required this.labelPt,
    required this.labelEn,
    required this.emoji,
  });

  String get label => labelPt;
}
