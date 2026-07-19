class PictogramCard {
  final String id;
  final String labelPt;
  final String labelEn;
  final String emoji;
  final String? speakPt;
  final String? speakEn;

  const PictogramCard({
    required this.id,
    required this.labelPt,
    required this.labelEn,
    required this.emoji,
    this.speakPt,
    this.speakEn,
  });

  String get label => labelPt;
}
