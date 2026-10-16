import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> saveUserProfile(String psnId, Map<String, dynamic> data) async {
    await _db.collection('users').doc(psnId).set(data, SetOptions(merge: true));
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> getUserProfile(String psnId) {
    return _db.collection('users').doc(psnId).snapshots();
  }

  Future<void> updateChecklistProgress(String psnId, String gameId, String itemId, bool completed) async {
    await _db.collection('users').doc(psnId).collection('checklists').doc(gameId).set({
      itemId: completed,
    }, SetOptions(merge: true));
  }
}
