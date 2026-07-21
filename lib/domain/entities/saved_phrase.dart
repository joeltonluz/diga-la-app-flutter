class SavedPhrase {
  final String id;
  final String? name;
  final List<String> cardIds;
  final DateTime createdAt;

  const SavedPhrase({
    required this.id,
    this.name,
    required this.cardIds,
    required this.createdAt,
  });

  SavedPhrase copyWith({
    String? id,
    String? name,
    List<String>? cardIds,
    DateTime? createdAt,
  }) =>
      SavedPhrase(
        id: id ?? this.id,
        name: name ?? this.name,
        cardIds: cardIds ?? this.cardIds,
        createdAt: createdAt ?? this.createdAt,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'cardIds': cardIds,
        'createdAt': createdAt.toIso8601String(),
      };

  factory SavedPhrase.fromJson(Map<String, dynamic> json) => SavedPhrase(
        id: json['id'] as String,
        name: json['name'] as String?,
        cardIds: List<String>.from(json['cardIds'] as List),
        createdAt: DateTime.parse(json['createdAt'] as String),
      );
}
