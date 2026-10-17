import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'psn_service.dart';

class PlatinumGalleryTab extends StatelessWidget {
  final String psnId;
  const PlatinumGalleryTab({Key? key, required this.psnId}) : super(key: key);

  static const Color backgroundColor = Color(0xFF0A0A0C);
  static const Color primaryPurple = Color(0xFF9D4EDD);
  static const Color surfaceDark = Color(0xFF141419);
  static const Color textMuted = Color(0xFFA0A0AB);

  Widget _buildStatTile(String label, String value) {
    return Column(
      children: [
        Text(value, style: const TextStyle(color: primaryPurple, fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 2),
        Text(label, style: const TextStyle(color: textMuted, fontSize: 11)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final PsnService psnService = PsnService();

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: surfaceDark,
        title: const Text('Perfil & Galeria de Platinas', style: TextStyle(color: Colors.white, fontSize: 18)),
      ),
      body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance.collection('users').doc(psnId).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(color: primaryPurple));
          }

          final userData = snapshot.data?.data() ?? {};
          final totalPlatinums = (userData['totalPlatinums'] as int?) ?? 0;
          final currentRank = psnService.calculatePlatinumRank(totalPlatinums);
          final isOmegod = currentRank == 'Omegod';

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: surfaceDark,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: isOmegod ? primaryPurple : primaryPurple.withOpacity(0.4),
                    width: isOmegod ? 2.5 : 1.0,
                  ),
                  boxShadow: isOmegod
                      ? [
                          BoxShadow(
                            color: primaryPurple.withOpacity(0.4),
                            blurRadius: 20,
                            spreadRadius: 2,
                          )
                        ]
                      : [],
                ),
                child: Column(
                  children: [
                    Container(
                      width: 84,
                      height: 84,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(0xFF050508),
                        border: Border.all(color: primaryPurple, width: 2),
                      ),
                      child: const Icon(Icons.emoji_events, color: primaryPurple, size: 48),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      psnId.isNotEmpty ? psnId : 'Caçador de Platinas',
                      style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        color: primaryPurple.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: primaryPurple),
                      ),
                      child: Text(
                        'RANK: ${currentRank.toUpperCase()}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          letterSpacing: 1.1,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildStatTile('Platinas', '$totalPlatinums'),
                        _buildStatTile('Status PSN', 'Conectado'),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Galeria de Jogos Concluídos',
                style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection('users').doc(psnId).collection('platinums').snapshots(),
                builder: (context, platSnapshot) {
                  if (!platSnapshot.hasData || platSnapshot.data!.docs.isEmpty) {
                    return Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: surfaceDark,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Center(
                        child: Text(
                          'Nenhuma platina registrada ainda.\nComplete os guias de troféus para adicionar ao seu perfil!',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: textMuted, fontSize: 13),
                        ),
                      ),
                    );
                  }

                  final docs = platSnapshot.data!.docs;

                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 0.85,
                    ),
                    itemCount: docs.length,
                    itemBuilder: (context, index) {
                      final item = docs[index].data() as Map<String, dynamic>;
                      final title = item['title'] ?? 'Jogo Concluído';
                      final date = item['date'] ?? 'Recente';

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
                            const Icon(Icons.emoji_events, color: primaryPurple, size: 40),
                            const SizedBox(height: 8),
                            Text(
                              title,
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13),
                            ),
                            const SizedBox(height: 6),
                            const Text('Conquistado em:', style: TextStyle(color: textMuted, fontSize: 10)),
                            Text(date, style: const TextStyle(color: textMuted, fontSize: 11, fontWeight: FontWeight.w600)),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
