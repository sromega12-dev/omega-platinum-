import 'package:flutter/material.dart';
import 'game_guide_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Captura erros de renderização e evita a tela cinza congelada
  ErrorWidget.builder = (FlutterErrorDetails details) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0C),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.warning_amber_rounded, size: 60, color: Color(0xFF9D4EDD)),
              const SizedBox(height: 16),
              const Text(
                'ERRO DE CARREGAMENTO NA TELA',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text(
                details.exceptionAsString(),
                style: const TextStyle(fontSize: 12, color: Colors.redAccent),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  };

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
      home: const GameGuideScreen(
        psnId: 'Omegod_User',
        gameId: 'omega_game_01',
      ),
    );
  }
}
