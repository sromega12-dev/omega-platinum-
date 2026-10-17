import 'package:flutter/material.dart';
import 'firestore_service.dart';
import 'sound_service.dart';

class GameGuideScreen extends StatefulWidget {
  final String psnId;
  final String gameId;
  const GameGuideScreen({Key? key, required this.psnId, required this.gameId}) : super(key: key);

  @override
  State<GameGuideScreen> createState() => _GameGuideScreenState();
}

class _GameGuideScreenState extends State<GameGuideScreen> {
  static const Color backgroundColor = Color(0xFF0A0A0C);
  static const Color primaryPurple = Color(0xFF9D4EDD);
  static const Color surfaceDark = Color(0xFF141419);
  static const Color textMuted = Color(0xFFA0A0AB);

  final FirestoreService _firestoreService = FirestoreService();

  final List<Map<String, dynamic>> _checklistItems = [
    {'id': 'item_1', 'title': 'Garras do Devorador', 'location': 'Ato 1 - Forte da Alegria', 'timestamp': '01:12', 'isCompleted': false},
    {'id': 'item_2', 'title': 'Passos do Devorador', 'location': 'Ato 2 - Costa da Parca', 'timestamp': '03:40', 'isCompleted': false},
    {'id': 'item_3', 'title': 'Coroa do Devorador', 'location': 'Ato 4 - Arx', 'timestamp': '08:15', 'isCompleted': false},
  ];

  Future<void> _onToggleCheckbox(int index, bool? value) async {
    if (value == null) return;

    final item = _checklistItems[index];
    final itemId = item['id'];

    setState(() {
      item['isCompleted'] = value;
    });

    if (value) {
      await SoundService.playTrophyDing();
    }

    await _firestoreService.updateChecklistProgress(
      widget.psnId,
      widget.gameId,
      itemId,
      value,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: surfaceDark,
        title: Text('${widget.gameId} - Guia', style: const TextStyle(color: Colors.white, fontSize: 18)),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _checklistItems.length,
        itemBuilder: (context, index) {
          final item = _checklistItems[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              color: surfaceDark,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: item['isCompleted'] ? primaryPurple.withOpacity(0.6) : primaryPurple.withOpacity(0.2),
              ),
            ),
            child: CheckboxListTile(
              activeColor: primaryPurple,
              checkColor: Colors.white,
              title: Text(
                item['title'],
                style: TextStyle(
                  color: item['isCompleted'] ? textMuted : Colors.white,
                  decoration: item['isCompleted'] ? TextDecoration.lineThrough : null,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                '${item['location']} • ⏱️ ${item['timestamp']}',
                style: const TextStyle(color: textMuted, fontSize: 12),
              ),
              value: item['isCompleted'],
              onChanged: (val) => _onToggleCheckbox(index, val),
            ),
          );
        },
      ),
    );
  }
}
