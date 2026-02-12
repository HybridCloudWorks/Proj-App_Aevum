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

// Mock Data
final List<FamilyMember> mockFamily = [
  FamilyMember(
    id: "gm-1",
    name: "Eleanor Ricci",
    relationship: "Great Grandmother",
    birthYear: "1920",
    deathYear: "1998",
    imageUrl: "https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=200",
  ),
  FamilyMember(
    id: "gp-1",
    name: "John Miller",
    relationship: "Grandfather",
    birthYear: "1945",
    deathYear: "2018",
    imageUrl:
        "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=200",
  ),
  FamilyMember(
    id: "fa-1",
    name: "Michael Johnson",
    relationship: "Father",
    birthYear: "1970",
    imageUrl:
        "https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=200",
  ),
];
