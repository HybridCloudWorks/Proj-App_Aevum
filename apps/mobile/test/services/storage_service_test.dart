import 'package:aevum_native/services/storage_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:uuid/uuid.dart';

class MockFirebaseFirestore extends Mock implements FirebaseFirestore {
  @override
  CollectionReference<Map<String, dynamic>> collection(String collectionPath) =>
      super.noSuchMethod(
        Invocation.method(#collection, [collectionPath]),
        returnValue: MockCollectionReference(),
      ) as CollectionReference<Map<String, dynamic>>;
}
class MockFirebaseAuth extends Mock implements FirebaseAuth {}
class MockFirebaseStorage extends Mock implements FirebaseStorage {}
class MockUser extends Mock implements User {
  @override
  String get uid => super.noSuchMethod(
        Invocation.getter(#uid),
        returnValue: '',
      ) as String;
}
class MockUuid extends Mock implements Uuid {
  @override
  String v4({
    Map<String, dynamic>? options,
    Object? config,
  }) =>
      super.noSuchMethod(
        Invocation.method(
          #v4,
          const [],
          <Symbol, dynamic>{
            #options: options,
            #config: config,
          },
        ),
        returnValue: '',
      ) as String;
}
class MockCollectionReference extends Mock
    implements CollectionReference<Map<String, dynamic>> {
  @override
  DocumentReference<Map<String, dynamic>> doc([String? path]) =>
      super.noSuchMethod(
        Invocation.method(#doc, [path]),
        returnValue: MockDocumentReference(),
      ) as DocumentReference<Map<String, dynamic>>;
}
class MockDocumentReference extends Mock
    implements DocumentReference<Map<String, dynamic>> {
  @override
  Future<void> set(Map<String, dynamic>? data, [SetOptions? options]) =>
      super.noSuchMethod(
        Invocation.method(#set, [data, options]),
        returnValue: Future<void>.value(),
        returnValueForMissingStub: Future<void>.value(),
      );
}

void main() {
  late StorageService storageService;
  late MockFirebaseFirestore mockFirestore;
  late MockFirebaseAuth mockAuth;
  late MockFirebaseStorage mockStorage;
  late MockUuid mockUuid;
  late MockUser mockUser;
  late MockCollectionReference mockCollection;
  late MockDocumentReference mockDocument;

  setUp(() {
    mockFirestore = MockFirebaseFirestore();
    mockAuth = MockFirebaseAuth();
    mockStorage = MockFirebaseStorage();
    mockUuid = MockUuid();
    mockUser = MockUser();
    mockCollection = MockCollectionReference();
    mockDocument = MockDocumentReference();

    storageService = StorageService(
      firestore: mockFirestore,
      auth: mockAuth,
      storage: mockStorage,
      uuid: mockUuid,
    );
  });

  group('StorageService - createAlbum', () {
    const String testName = 'Test Album';
    const String testDescription = 'Test Description';
    const String testUid = 'user123';
    const String testFamilyId = 'family123';
    const String testAlbumId = 'uuid-1234';

    test('throws Exception when user is not authenticated', () async {
      when(mockAuth.currentUser).thenReturn(null);

      expect(
        () => storageService.createAlbum(
          testName,
          familyId: testFamilyId,
        ),
        throwsA(
          isA<Exception>().having(
            (e) => e.toString(),
            'message',
            contains('User not authenticated'),
          ),
        ),
      );
    });

    test('creates a family-scoped album when authenticated', () async {
      when(mockAuth.currentUser).thenReturn(mockUser);
      when(mockUser.uid).thenReturn(testUid);
      when(mockUuid.v4()).thenReturn(testAlbumId);
      when(mockFirestore.collection('albums')).thenReturn(mockCollection);
      when(mockCollection.doc(testAlbumId)).thenReturn(mockDocument);
      when(mockDocument.set(any)).thenAnswer((_) => Future.value());

      final result = await storageService.createAlbum(
        testName,
        familyId: testFamilyId,
        description: testDescription,
      );

      expect(result, testAlbumId);
      verify(mockFirestore.collection('albums')).called(1);
      verify(mockCollection.doc(testAlbumId)).called(1);
      final Map<String, dynamic> payload =
          verify(mockDocument.set(captureAny)).captured.single
              as Map<String, dynamic>;
      expect(payload['familyId'], testFamilyId);
      expect(payload['createdBy'], testUid);
      expect(payload['name'], testName);
      expect(payload['description'], testDescription);
      expect(payload['mediaIds'], <String>[]);
    });

    test('uses an empty description by default', () async {
      when(mockAuth.currentUser).thenReturn(mockUser);
      when(mockUser.uid).thenReturn(testUid);
      when(mockUuid.v4()).thenReturn(testAlbumId);
      when(mockFirestore.collection('albums')).thenReturn(mockCollection);
      when(mockCollection.doc(testAlbumId)).thenReturn(mockDocument);
      when(mockDocument.set(any)).thenAnswer((_) => Future.value());

      final result = await storageService.createAlbum(
        testName,
        familyId: testFamilyId,
      );

      expect(result, testAlbumId);
      verify(mockDocument.set(argThat(containsPair('description', '')))).called(1);
    });

    test('does not store legacy owner/sharedWith authorization fields', () async {
      when(mockAuth.currentUser).thenReturn(mockUser);
      when(mockUser.uid).thenReturn(testUid);
      when(mockUuid.v4()).thenReturn(testAlbumId);
      when(mockFirestore.collection('albums')).thenReturn(mockCollection);
      when(mockCollection.doc(testAlbumId)).thenReturn(mockDocument);
      when(mockDocument.set(any)).thenAnswer((_) => Future.value());

      await storageService.createAlbum(testName, familyId: testFamilyId);

      final verification = verify(mockDocument.set(captureAny));
      final Map<String, dynamic> payload =
          verification.captured.single as Map<String, dynamic>;
      expect(payload.containsKey('ownerId'), isFalse);
      expect(payload.containsKey('sharedWith'), isFalse);
      expect(payload['familyId'], testFamilyId);
      expect(payload['createdBy'], testUid);
    });
  });
}
