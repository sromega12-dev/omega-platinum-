import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'game_guide_screen.dart';

class GameSearchScreen extends StatefulWidget {
  final String psnId;
  const GameSearchScreen({Key? key, required this.psnId}) : super(key: key);

  @override
  State<GameSearchScreen> createState() => _GameSearchScreenState();
}

class _GameSearchScreenState extends State<GameSearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  static const Color backgroundColor = Color(0xFF0A0A0C);
  static const Color primaryPurple = Color(0xFF9D4EDD);
  static const Color surfaceDark = Color(0xFF141419);
  static const Color textMuted = Color(0xFFA0A0AB);

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: surfaceDark,
        elevation: 0,
        title: const Text(
          'Buscar Guias de Platinas',
          style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16.0),
            color: surfaceDark,
            child: TextField(
              controller: _searchController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Digite o nome do jogo (ex: Elden Ring)...',
                hintStyle: const TextStyle(color: textMuted),
                prefixIcon: const Icon(Icons.search, color: primaryPurple),
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear, color: textMuted),
                        onPressed: () {
                          setState(() {
                            _searchController.clear();
                            _searchQuery = '';
                          });
                        },
                      )
                    : null,
                filled: true,
                fillColor: backgroundColor,
                contentPadding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide(color: primaryPurple.withOpacity(0.3)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: const BorderSide(color: primaryPurple, width: 1.5),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value.trim().toLowerCase();
                });
              },
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('games').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator(color: primaryPurple));
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(
                    child: Text(
                      'Nenhum guia encontrado na nuvem.\nUse a opção em Ajustes para carregar os jogos!',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: textMuted, fontSize: 14),
                    ),
                  );
                }

                final filteredDocs = snapshot.data!.docs.where((doc) {
                  final data = doc.data() as Map<String, dynamic>;
                  final title = (data['title'] ?? '').toString().toLowerCase();
                  return title.contains(_searchQuery);
                }).toList();

                if (filteredDocs.isEmpty) {
                  return const Center(
                    child: Text(
                      'Nenhum jogo corresponde à sua busca.',
                      style: TextStyle(color: textMuted, fontSize: 14),
                    ),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.all(16.0),
                  itemCount: filteredDocs.length,
                  itemBuilder: (context, index) {
                    final gameDoc = filteredDocs[index];
                    final gameData = gameDoc.data() as Map<String, dynamic>;
                    final gameId = gameDoc.id;
                    final title = gameData['title'] ?? 'Jogo sem título';
                    final difficulty = gameData['difficulty'] ?? 'N/A';
                    final estimatedTime = gameData['estimatedTime'] ?? 'N/A';

                    return Container(
                      margin: const EdgeInsets.only(bottom: 12.0),
                      decoration: BoxDecoration(
                        color: surfaceDark,
                        borderRadius: BorderRadius.circular(12.0),
                        border: Border.all(color: primaryPurple.withOpacity(0.3)),
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                        leading: Container(
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            color: primaryPurple.withOpacity(0.15),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.sports_esports, color: primaryPurple),
                        ),
                        title: Text(
                          title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: Row(
                            children: [
                              Text('Dificuldade: $difficulty', style: const TextStyle(color: textMuted, fontSize: 12)),
                              const SizedBox(width: 12),
                              Text('Tempo: $estimatedTime', style: const TextStyle(color: textMuted, fontSize: 12)),
                            ],
                          ),
                        ),
                        trailing: const Icon(Icons.arrow_forward_ios, color: primaryPurple, size: 16),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => GameGuideScreen(
                                gameId: gameId,
                                gameTitle: title,
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
