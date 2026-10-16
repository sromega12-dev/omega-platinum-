import 'package:flutter/material.dart';
import 'game_guide_screen.dart'; // Importa a sua tela real

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
      // Aponta diretamente para o ecrã real do seu app:
      home: const GameGuideScreen(),
    );
  }
}
