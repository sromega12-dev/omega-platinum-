import 'package:flutter/material.dart';

class PlatinumGalleryTab extends StatelessWidget {
  const PlatinumGalleryTab({Key? key}) : super(key: key);

  static const Color backgroundColor = Color(0xFF0A0A0C);
  static const Color primaryPurple = Color(0xFF9D4EDD);
  static const Color surfaceDark = Color(0xFF141419);
  static const Color textMuted = Color(0xFFA0A0AB);

  final List<Map<String, String>> _platinums = const [
    {
      'title': 'Divinity: Original Sin 2',
      'date': '15/10/2023',
      'hours': '142h',
      'difficulty': '9/10',
    },
    {
      'title': 'Bloodborne',
      'date': '02/08/2023',
      'hours': '68h',
      'difficulty': '7/10',
    },
    {
      'title': 'Elden Ring',
      'date': '20/03/2023',
      'hours': '110h',
      'difficulty': '6/10',
    },
    {
      'title': 'Silent Hill 2 Remake',
      'date': '10/11/2025',
      'hours': '35h',
      'difficulty': '5/10',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: surfaceDark,
        title: const Text('Galeria de Platinas', style: TextStyle(color: Colors.white, fontSize: 18)),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 0.8,
        ),
        itemCount: _platinums.length,
        itemBuilder: (context, index) {
          final item = _platinums[index];
          return Container(
            decoration: BoxDecoration(
              color: surfaceDark,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: primaryPurple.withOpacity(0.4)),
            ),
            padding: const EdgeInsets.all(12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.emoji_events, color: primaryPurple, size: 48),
                const SizedBox(height: 8),
                Text(
                  item['title']!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
                ),
                const SizedBox(height: 4),
                Text('Conquistado em: ${item['date']}', style: const TextStyle(color: textMuted, fontSize: 11)),
                Text('Tempo: ${item['hours']} | Dificuldade: ${item['difficulty']}', style: const TextStyle(color: textMuted, fontSize: 11)),
              ],
            ),
          );
        },
      ),
    );
  }
}
