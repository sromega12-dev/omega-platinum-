import 'package:flutter/material.dart';
import 'game_guide_screen.dart';

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
      // Passando os parâmetros obrigatórios exigidos pela tela:
      home: const GameGuideScreen(
        psnId: 'Omegod_User',
        gameId: 'omega_game_01',
      ),
    );
  }
}
