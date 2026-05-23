import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';
import '../config/constants.dart';

class DatabaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Uuid _uuid = const Uuid();

  // ==========================================
  // Family Tree & Members
  // ==========================================

  /// Streams the total count of members in the user's family tree
  Stream<int> getMemberCountStream() {
    final user = _auth.currentUser;
    if (user == null) return Stream.value(0);

    return _firestore
        .collection('members')
        .where('userId', isEqualTo: user.uid)
        .snapshots()
        .map((snapshot) => snapshot.docs.length);
  }

  /// Merges a predicted branch/ancestor into the family tree
  Future<void> mergeBranch({
    required String name,
    required String relation,
    required String birthYear,
    required String deathYear,
    required String photoUrl,
    String? parentId,
  }) async {
    final user = _auth.currentUser;
    if (user == null) throw Exception('User not authenticated');

    final String memberId = _uuid.v4();
    await _firestore.collection('members').doc(memberId).set({
      'id': memberId,
      'userId': user.uid,
      'name': name,
      'relation': relation,
      'birthYear': birthYear,
      'deathYear': deathYear,
      'photoUrl': photoUrl,
      'parentId': parentId,
      'mergedAt': FieldValue.serverTimestamp(),
      'isAIGenerated': true,
    });
  }

  // ==========================================
  // AI Tasks
  // ==========================================

  /// Streams the list of pending AI tasks
  Stream<List<Map<String, dynamic>>> getAITasksStream() {
    final user = _auth.currentUser;
    if (user == null) return Stream.value([]);

    return _firestore
        .collection('ai_tasks')
        .where('userId', isEqualTo: user.uid)
        .where('status', isNotEqualTo: 'completed')
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => {...doc.data(), 'id': doc.id})
              .toList(),
        );
  }

  /// Updates the status of an AI task
  Future<void> updateTaskStatus(String taskId, String status) async {
    await _firestore.collection('ai_tasks').doc(taskId).update({
      'status': status,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  /// Creates a mock AI task for demonstration if none exist
  Future<void> createMockTask() async {
    final user = _auth.currentUser;
    if (user == null) return;

    final String taskId = _uuid.v4();
    await _firestore.collection('ai_tasks').doc(taskId).set({
      'userId': user.uid,
      'title': "Grandpa '54",
      'type': "Enhance color",
      'status': "pending",
      'imageUrl': AppConstants.mockTaskImageUrl,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }
}
