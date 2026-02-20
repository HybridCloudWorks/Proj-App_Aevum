class FamilyMember {
  final String id;
  final String name;
  final String relationship;
  final String birthYear;
  final String? deathYear;
  final String imageUrl;
  final List<String> linkedMediaIds;

  FamilyMember({
    required this.id,
    required this.name,
    required this.relationship,
    required this.birthYear,
    this.deathYear,
    required this.imageUrl,
    this.linkedMediaIds = const [],
  });

  String get lifeSpan => "$birthYear - ${deathYear ?? 'Present'}";
}


