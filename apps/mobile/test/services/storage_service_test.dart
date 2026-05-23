import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';
import 'package:aevum_native/services/storage_service.dart';

class MockFirebaseFirestore extends Mock implements FirebaseFirestore {}
class MockFirebaseAuth extends Mock implements FirebaseAuth {}
class MockFirebaseStorage extends Mock implements FirebaseStorage {}
class MockUser extends Mock implements User {}
class MockUuid extends Mock implements Uuid {}
class MockCollectionReference extends Mock implements CollectionReference<Map<String, dynamic>> {}
class MockDocumentReference extends Mock implements DocumentReference<Map<String, dynamic>> {
  @override
  Future<void> set(Map<String, dynamic>? data, [SetOptions? options]) =>
      super.noSuchMethod(Invocation.method(#set, [data, options]), returnValue: Future<void>.value(), returnValueForMissingStub: Future<void>.value());
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
    const String testTitle = 'Test Album';
    const String testDescription = 'Test Description';
    const String testUid = 'user123';
    const String testAlbumId = 'uuid-1234';

    test('throws Exception when user is not authenticated', () async {
      when(mockAuth.currentUser).thenReturn(null);

      expect(
        () => storageService.createAlbum(testTitle),
        throwsA(isA<Exception>().having(
          (e) => e.toString(),
          'message',
          contains('User not authenticated'),
        )),
      );
    });

    test('successfully creates an album when authenticated', () async {
      when(mockAuth.currentUser).thenReturn(mockUser);
      when(mockUser.uid).thenReturn(testUid);
      when(mockUuid.v4()).thenReturn(testAlbumId);
      when(mockFirestore.collection('albums')).thenReturn(mockCollection);
      when(mockCollection.doc(testAlbumId)).thenReturn(mockDocument);
      when(mockDocument.set(any)).thenAnswer((_) => Future.value());

      final result = await storageService.createAlbum(
        testTitle,
        description: testDescription,
      );

      expect(result, testAlbumId);

      verify(mockFirestore.collection('albums')).called(1);
      verify(mockCollection.doc(testAlbumId)).called(1);
      verify(mockDocument.set(argThat(containsPair('id', testAlbumId)))).called(1);
      verify(mockDocument.set(argThat(containsPair('ownerId', testUid)))).called(1);
      verify(mockDocument.set(argThat(containsPair('title', testTitle)))).called(1);
      verify(mockDocument.set(argThat(containsPair('description', testDescription)))).called(1);
      verify(mockDocument.set(argThat(containsPair('itemCount', 0)))).called(1);
    });

    test('successfully creates an album with default description', () async {
      when(mockAuth.currentUser).thenReturn(mockUser);
      when(mockUser.uid).thenReturn(testUid);
      when(mockUuid.v4()).thenReturn(testAlbumId);
      when(mockFirestore.collection('albums')).thenReturn(mockCollection);
      when(mockCollection.doc(testAlbumId)).thenReturn(mockDocument);
      when(mockDocument.set(any)).thenAnswer((_) => Future.value());

      final result = await storageService.createAlbum(testTitle);

      expect(result, testAlbumId);
      verify(mockDocument.set(argThat(containsPair('description', '')))).called(1);
    });

    test('createAlbum includes expected initial fields', () async {
      when(mockAuth.currentUser).thenReturn(mockUser);
      when(mockUser.uid).thenReturn(testUid);
      when(mockUuid.v4()).thenReturn(testAlbumId);
      when(mockFirestore.collection('albums')).thenReturn(mockCollection);
      when(mockCollection.doc(testAlbumId)).thenReturn(mockDocument);
      when(mockDocument.set(any)).thenAnswer((_) => Future.value());

      await storageService.createAlbum(testTitle);

      verify(mockDocument.set(argThat(containsPair('sharedWith', [])))).called(1);
      verify(mockDocument.set(argThat(containsPair('coverPhotoUrl', null)))).called(1);
    });
  });
}
