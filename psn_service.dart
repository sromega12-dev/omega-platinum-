import 'package:cloud_firestore/cloud_firestore.dart';

class PsnService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<bool> registerOrUpdatePsnId(String psnId) async {
    try {
      final trimmedId = psnId.trim();
      if (trimmedId.isEmpty) return false;

      final userRef = _db.collection('users').doc(trimmedId);
      final doc = await userRef.get();

      if (!doc.exists) {
        await userRef.set({
          'psnId': trimmedId,
          'currentRank': 'Novice Platinum',
          'totalPlatinums': 0,
          'createdAt': FieldValue.serverTimestamp(),
        });
      }
      return true;
    } catch (e) {
      print('Erro ao registrar PSN ID: $e');
      return false;
    }
  }

  String calculatePlatinumRank(int totalPlatinums) {
    if (totalPlatinums >= 200) return 'Omegod';
    if (totalPlatinums >= 100) return 'Master Platinum';
    if (totalPlatinums >= 50) return 'Expert Platinum';
    if (totalPlatinums >= 10) return 'Platinum Hunter';
    return 'Novice Platinum';
  }

  Future<void> addPlatinum(String psnId, int currentTotal) async {
    int newTotal = currentTotal + 1;
    String newRank = calculatePlatinumRank(newTotal);

    await _db.collection('users').doc(psnId).update({
      'totalPlatinums': newTotal,
      'currentRank': newRank,
      'lastUpdated': FieldValue.serverTimestamp(),
    });
  }
}
