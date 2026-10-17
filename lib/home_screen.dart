import 'package:cloud_firestore/cloud_firestore.dart';

class GameSeeder {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> seedAllGuides() async {
    await seedDivinityGuide();
    await seedEldenRingGuide();
    await seedBloodborneGuide();
    await seedSilentHill2Guide();
  }

  Future<void> seedDivinityGuide() async {
    final gameRef = _db.collection('games').doc('divinity_original_sin_2');
    await gameRef.set({
      'title': 'Divinity: Original Sin 2',
      'difficulty': '9/10',
      'estimatedTime': '142h',
    });
    await gameRef.collection('guides').doc('act1_fort_joy').set({
      'sectionName': 'Ato 1 - Forte da Alegria',
    });
    await gameRef
        .collection('guides')
        .doc('act1_fort_joy')
        .collection('items')
        .doc('devourer_claws')
        .set({
      'title': 'Garras do Devorador',
      'location': 'Ato 1 - Cavernas',
      'timestamp': '01:12',
    });
  }

  Future<void> seedEldenRingGuide() async {
    final gameRef = _db.collection('games').doc('elden_ring');
    await gameRef.set({
      'title': 'Elden Ring',
      'difficulty': '6/10',
      'estimatedTime': '110h',
    });
    await gameRef.collection('guides').doc('legendary_armaments').set({
      'sectionName': 'Armamentos Lendários',
    });
    await gameRef
        .collection('guides')
        .doc('legendary_armaments')
        .collection('items')
        .doc('sword_of_night_and_flame')
        .set({
      'title': 'Espada da Noite e da Chama',
      'location': 'Mansão Caria',
      'timestamp': '02:15',
    });
  }

  Future<void> seedBloodborneGuide() async {
    final gameRef = _db.collection('games').doc('bloodborne');
    await gameRef.set({
      'title': 'Bloodborne',
      'difficulty': '7/10',
      'estimatedTime': '68h',
    });
    await gameRef.collection('guides').doc('hunter_tools').set({
      'sectionName': 'Ferramentas de Caçador',
    });
    await gameRef
        .collection('guides')
        .doc('hunter_tools')
        .collection('items')
        .doc('executioners_glove')
        .set({
      'title': 'Luva do Executor',
      'location': 'Castelgaton Cainhurst',
      'timestamp': '04:30',
    });
  }

  Future<void> seedSilentHill2Guide() async {
    final gameRef = _db.collection('games').doc('silent_hill_2_remake');
    await gameRef.set({
      'title': 'Silent Hill 2 Remake',
      'difficulty': '5/10',
      'estimatedTime': '25h',
    });
    await gameRef.collection('guides').doc('memos_and_puzzles').set({
      'sectionName': 'Memos e Enigmas Críticos',
    });
    await gameRef
        .collection('guides')
        .doc('memos_and_puzzles')
        .collection('items')
        .doc('hospital_safe_code')
        .set({
      'title': 'Código do Cofre do Hospital Brookhaven',
      'location': 'Diretorência - 2º Andar',
      'timestamp': '01:45',
    });
  }
}
