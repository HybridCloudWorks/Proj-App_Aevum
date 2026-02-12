import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';
import 'package:path/path.dart' as path;

class StorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Uuid _uuid = const Uuid();

  /// Uploads a file to Firebase Storage and creates a corresponding Firestore document.
  /// Returns the document ID (UUID) of the uploaded media.
  Future<String?> uploadMedia({
    required File file,
    required String category, // e.g., 'family_photos', 'documents', 'scans'
    String? description,
    List<String>? tags,
    String? albumId,
  }) async {
    try {
      final User? user = _auth.currentUser;
      if (user == null) throw Exception('User not authenticated');

      // 1. Generate Unique ID & Path Strategy
      // Path: uploads/{userId}/{year}/{month}/{category}/{uuid}.ext
      final String uuid = _uuid.v4();
      final String fileExt = path.extension(file.path);
      final DateTime now = DateTime.now();
      final String storagePath =
          'uploads/${user.uid}/${now.year}/${now.month}/$category/$uuid$fileExt';

      // 2. Upload to Firebase Storage
      final Reference ref = _storage.ref().child(storagePath);
      final UploadTask uploadTask = ref.putFile(
        file,
        SettableMetadata(
          contentType: 'image/${fileExt.replaceAll('.', '')}',
          customMetadata: {
            'originalName': path.basename(file.path),
            'uploadedBy': user.uid,
            'category': category,
            'uuid': uuid,
          },
        ),
      );

      final TaskSnapshot snapshot = await uploadTask;
      final String downloadUrl = await snapshot.ref.getDownloadURL();

      // 3. Create Metadata Document in Firestore
      // Global Collection: media_items (for scalable querying)
      // Categorization happens via fields, not folder structure.
      await _firestore.collection('media_items').doc(uuid).set({
        'id': uuid,
        'userId': user.uid,
        'storagePath': storagePath,
        'url': downloadUrl,
        'category': category, // High-level Type: Photo, Video, Document
        'tags': tags ?? [],
        'albumIds': albumId != null ? [albumId] : [],
        'description': description ?? '',
        'metadata': {
          'size': snapshot.totalBytes,
          'contentType': snapshot.metadata?.contentType,
          'created': FieldValue.serverTimestamp(),
          'originalName': path.basename(file.path),
        },
        'aiStatus': 'pending', // Trigger for AI processing
      });

      return uuid;
    } catch (e) {
      // Error handling should ideally use a logging framework
      return null;
    }
  }

  /// Requests AI restoration for a media item.
  Future<void> requestRestoration({
    required String mediaId,
    required bool colorize,
    required bool sharpen,
    required bool repair,
  }) async {
    try {
      await _firestore.collection('media_items').doc(mediaId).update({
        'aiStatus': 'restoration_pending',
        'restorationParams': {
          'colorize': colorize,
          'sharpen': sharpen,
          'repair': repair,
          'requestedAt': FieldValue.serverTimestamp(),
        },
      });
    } catch (e) {
      rethrow;
    }
  }

  /// Creates a new logical Album in Firestore.
  Future<String> createAlbum(String title, {String? description}) async {
    final User? user = _auth.currentUser;
    if (user == null) throw Exception('User not authenticated');

    final String albumId = _uuid.v4();
    await _firestore.collection('albums').doc(albumId).set({
      'id': albumId,
      'ownerId': user.uid,
      'title': title,
      'description': description ?? '',
      'created': FieldValue.serverTimestamp(),
      'coverPhotoUrl': null,
      'itemCount': 0,
      'sharedWith': [],
    });
    return albumId;
  }
}
