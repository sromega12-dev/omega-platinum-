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
  static const Color backgroundColor = Color(0xFF0A0A0C);
  static const Color primaryPurple = Color(0xFF9D4EDD);
  static const Color surfaceDark = Color(0xFF141419);
  static const Color textMuted = Color(0xFFA0A0AB);

  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: surfaceDark,
        title: const Text(
          'Pesquisar Guias de Platinas',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
      body: Column(
        children: [
          // Barra de Pesquisa Moderna
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              decoration: BoxDecoration(
                color: surfaceDark,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: primaryPurple.withOpacity(0.5)),
              ),
              child: TextField(
                controller: _searchController,
                style: const TextStyle(color: Colors.white),
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value.trim().toLowerCase();
                  });
                },
                decoration: const InputDecoration(
                  hintText: 'Digite o nome do jogo (ex: Elden Ring)...',
                  hintStyle: TextStyle(color: textMuted),
                  prefixIcon: Icon(Icons.search, color: primaryPurple),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                ),
              ),
            ),
          ),

          // Lista Dinâmica baseada no Firestore
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('games').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(color: primaryPurple),
                  );
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(
                    child: Text(
                      'Nenhum guia encontrado na nuvem.',
                      style: TextStyle(color: textMuted),
                    ),
                  );
                }

                // Filtra os jogos em tempo real com base no que foi digitado na barra de pesquisa
                final docs = snapshot.data!.docs.where((doc) {
                  final data = doc.data() as Map<String, dynamic>;
                  final title = (data['title'] ?? '').toString().toLowerCase();
                  return title.contains(_searchQuery);
                }).toList();

                if (docs.isEmpty) {
                  return const Center(
                    child: Text(
                      'Nenhum jogo corresponde à pesquisa.',
                      style: TextStyle(color: textMuted),
                    ),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: docs.length,
                  itemBuilder: (context, index) {
                    final gameData = docs[index].data() as Map<String, dynamic>;
                    final gameId = docs[index].id;
                    final title = gameData['title'] ?? 'Jogo Desconhecido';
                    final difficulty = gameData['difficulty'] ?? 'N/A';
                    final estimatedTime = gameData['estimatedTime'] ?? 'N/A';

                    return Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      decoration: BoxDecoration(
                        color: surfaceDark,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: primaryPurple.withOpacity(0.3)),
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(16),
                        leading: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: primaryPurple.withOpacity(0.15),
                            shape: BoxShape.circle,
                          ),
                          icon: const Icon(Icons.sports_esports, color: primaryPurple),
                        ),
                        title: Text(
                          title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.only(top: 6.0),
                          child: Text(
                            'Dificuldade: $difficulty • Tempo: $estimatedTime',
                            style: const TextStyle(color: textMuted, fontSize: 12),
                          ),
                        ),
                        trailing: const Icon(Icons.arrow_forward_ios, color: primaryPurple, size: 16),
                        onTap: () {
                          // Abre o guia detalhado daquele jogo específico
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => GameGuideScreen(
                                psnId: widget.psnId,
                                gameId: gameId,
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
