import 'package:flutter_test/flutter_test.dart';
import 'package:aevum_native/models/family_member.dart';

void main() {
  group('FamilyMember', () {
    test('lifeSpan returns correct string when member is living (deathYear is null)', () {
      final member = FamilyMember(
        id: '1',
        name: 'John Doe',
        relationship: 'Father',
        birthYear: '1970',
        imageUrl: 'https://example.com/image.jpg',
      );

      expect(member.lifeSpan, '1970 - Present');
    });

    test('lifeSpan returns correct string when member is deceased (deathYear provided)', () {
      final member = FamilyMember(
        id: '2',
        name: 'Jane Doe',
        relationship: 'Grandmother',
        birthYear: '1920',
        deathYear: '2005',
        imageUrl: 'https://example.com/image.jpg',
      );

      expect(member.lifeSpan, '1920 - 2005');
    });
  });
}
