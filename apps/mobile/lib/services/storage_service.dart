import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as path;
import 'package:uuid/uuid.dart';

class StorageService {
  final FirebaseStorage _storage;
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;
  final Uuid _uuid;

  StorageService({
    FirebaseStorage? storage,
    FirebaseFirestore? firestore,
    FirebaseAuth? auth,
    Uuid? uuid,
  })  : _storage = storage ?? FirebaseStorage.instance,
        _firestore = firestore ?? FirebaseFirestore.instance,
        _auth = auth ?? FirebaseAuth.instance,
        _uuid = uuid ?? const Uuid();

  String _safeFileName(String filePath) {
    return path.basename(filePath).replaceAll(RegExp(r'[^A-Za-z0-9._-]'), '_');
  }

  String _contentType(String filePath) {
    switch (path.extension(filePath).toLowerCase()) {
      case '.jpg':
      case '.jpeg':
        return 'image/jpeg';
      case '.png':
        return 'image/png';
      case '.webp':
        return 'image/webp';
      case '.heic':
        return 'image/heic';
      case '.heif':
        return 'image/heif';
      default:
        throw ArgumentError('Unsupported image type: ${path.extension(filePath)}');
    }
  }

  /// Reserve a canonical media record, upload its immutable original, and mark
  /// the record uploaded. The backend preservation processor owns derivatives,
  /// archival copies, EXIF normalization, and AI handoff.
  Future<String> uploadMedia({
    required File file,
    required String familyId,
    required String category,
    String? title,
    String? description,
    List<String>? tags,
    String? albumId,
  }) async {
    final User? user = _auth.currentUser;
    if (user == null) throw Exception('User not authenticated');

    final String mediaId = _uuid.v4();
    final String fileName = _safeFileName(file.path);
    final String contentType = _contentType(file.path);
    final String storagePath =
        'families/$familyId/media/$mediaId/original/$fileName';
    final DocumentReference<Map<String, dynamic>> mediaRef =
        _firestore.collection('media_items').doc(mediaId);

    await mediaRef.set({
      'familyId': familyId,
      'createdBy': user.uid,
      'uploadedBy': user.uid,
      'title': title ?? path.basenameWithoutExtension(file.path),
      'description': description ?? '',
      'category': category,
      'tags': tags ?? <String>[],
      'memberIds': <String>[],
      'albumIds': albumId != null ? <String>[albumId] : <String>[],
      'status': 'uploading',
      'aiStatus': 'waiting',
      'storage': <String, dynamic>{},
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    });

    try {
      final Reference storageRef = _storage.ref().child(storagePath);
      final TaskSnapshot snapshot = await storageRef.putFile(
        file,
        SettableMetadata(
          contentType: contentType,
          customMetadata: {
            'mediaId': mediaId,
            'familyId': familyId,
            'uploadedBy': user.uid,
            'originalName': path.basename(file.path),
          },
        ),
      );
      final String downloadUrl = await snapshot.ref.getDownloadURL();

      await mediaRef.update({
        'status': 'uploaded',
        'photoUrl': downloadUrl,
        'thumbnailUrl': downloadUrl,
        'storage.originalPath': storagePath,
        'imageMetadata': {
          'fileSize': snapshot.totalBytes,
          'contentType': snapshot.metadata?.contentType ?? contentType,
          'originalName': path.basename(file.path),
        },
        'uploadCompletedAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      });

      return mediaId;
    } catch (error) {
      await mediaRef.update({
        'status': 'upload_failed',
        'uploadError': error.toString(),
        'updatedAt': FieldValue.serverTimestamp(),
      });
      rethrow;
    }
  }

  Future<void> requestRestoration({
    required String mediaId,
    required bool colorize,
    required bool sharpen,
    required bool repair,
  }) async {
    await _firestore.collection('media_items').doc(mediaId).update({
      'aiStatus': 'restoration_pending',
      'restorationParams': {
        'colorize': colorize,
        'sharpen': sharpen,
        'repair': repair,
        'requestedAt': FieldValue.serverTimestamp(),
      },
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  /// Create a family-scoped album. Authorization is inherited from family RBAC;
  /// a genealogical relationship never grants application access.
  Future<String> createAlbum(
    String name, {
    required String familyId,
    String? description,
  }) async {
    final User? user = _auth.currentUser;
    if (user == null) throw Exception('User not authenticated');

    final String albumId = _uuid.v4();
    await _firestore.collection('albums').doc(albumId).set({
      'familyId': familyId,
      'createdBy': user.uid,
      'name': name,
      'description': description ?? '',
      'mediaIds': <String>[],
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    });
    return albumId;
  }
}
