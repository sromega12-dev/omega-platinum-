import 'package:flutter/material.dart';

void main() {
  // Inicialização direta do Flutter sem bloqueios externos
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
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0C),
      appBar: AppBar(
        title: const Text(
          'OMEGA PLATINUM',
          style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.2),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF9D4EDD).withOpacity(0.2),
                border: Border.all(color: const Color(0xFF9D4EDD), width: 2),
              ),
              child: const Icon(
                Icons.emoji_events,
                size: 80,
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
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Color(0xFF9D4EDD),
                letterSpacing: 1.5,
              ),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF9D4EDD),
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Troféu Omega Platinum ativado!'),
                    backgroundColor: Color(0xFF9D4EDD),
                  ),
                );
              },
              child: const Text(
                'TESTAR RECURSO',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
