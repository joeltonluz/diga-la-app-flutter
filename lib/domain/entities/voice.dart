class Voice {
  final String name;
  final String locale;

  const Voice({required this.name, required this.locale});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Voice && name == other.name && locale == other.locale;

  @override
  int get hashCode => Object.hash(name, locale);
}
