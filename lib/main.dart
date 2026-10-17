import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const OmegaPlatinumApp());
}

class OmegaPlatinumApp extends StatelessWidget {
  const OmegaPlatinumApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Omega Platinum',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF0A0A0C), // Dark OLED
        primaryColor: const Color(0xFF9D4EDD), // Roxo Neon
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF9D4EDD),
          surface: Color(0xFF0A0A0C),
        ),
      ),
      home: const OmegaHomeScreen(),
    );
  }
}

class OmegaHomeScreen extends StatelessWidget {
  const OmegaHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0C),
      appBar: AppBar(
        title: const Text(
          'OMEGA PLATINUM',
          style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.5, color: Colors.white),
        ),
        backgroundColor: const Color(0xFF0A0A0C),
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF9D4EDD).withOpacity(0.15),
                border: Border.all(color: const Color(0xFF9D4EDD), width: 2),
              ),
              child: const Icon(
                Icons.emoji_events,
                size: 70,
                color: Color(0xFF9D4EDD),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'RANK SUPREMO',
              style: TextStyle(fontSize: 14, color: Colors.grey, letterSpacing: 2),
            ),
            const SizedBox(height: 8),
            const Text(
              'OMEGOD',
              style: TextStyle(
                fontSize: 34,
                fontWeight: FontWeight.bold,
                color: Color(0xFF9D4EDD),
                letterSpacing: 2,
              ),
            ),
            const SizedBox(height: 48),
            Card(
              color: const Color(0xFF16161A),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: ListTile(
                leading: const Icon(Icons.sports_esports, color: Color(0xFF9D4EDD), size: 30),
                title: const Text('Guia de Troféus', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                subtitle: const Text('Estado: Online & Sincronizado', style: TextStyle(color: Colors.grey, fontSize: 12)),
                trailing: const Icon(Icons.arrow_forward_ios, color: Color(0xFF9D4EDD), size: 16),
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Guia carregado com sucesso!'),
                      backgroundColor: Color(0xFF9D4EDD),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            Card(
              color: const Color(0xFF16161A),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: ListTile(
                leading: const Icon(Icons.military_tech, color: Color(0xFF9D4EDD), size: 30),
                title: const Text('Platinas Conquistadas', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                subtitle: const Text('Perfil Omegod Ativo', style: TextStyle(color: Colors.grey, fontSize: 12)),
                trailing: const Icon(Icons.arrow_forward_ios, color: Color(0xFF9D4EDD), size: 16),
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Platinas atualizadas!'),
                      backgroundColor: Color(0xFF9D4EDD),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
