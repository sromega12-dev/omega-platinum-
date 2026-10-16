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
      home: const SafeGameGuideWrapper(),
    );
  }
}

// Wrapper seguro que impede o congelamento da tela cinza
class SafeGameGuideWrapper extends StatefulWidget {
  const SafeGameGuideWrapper({super.key});

  @override
  State<SafeGameGuideWrapper> createState() => _SafeGameGuideWrapperState();
}

class _SafeGameGuideWrapperState extends State<SafeGameGuideWrapper> {
  bool _isReady = false;

  @override
  void initState() {
    super.initState();
    // Dá um respiro de 1 segundo para o motor gráfico renderizar o tema Dark OLED
    // antes de tentar puxar os dados pesados da GameGuideScreen
    Future.delayed(const Duration(milliseconds: 1000), () {
      if (mounted) {
        setState(() {
          _isReady = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_isReady) {
      return Scaffold(
        backgroundColor: const Color(0xFF0A0A0C),
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
                child: const Icon(Icons.emoji_events, size: 60, color: Color(0xFF9D4EDD)),
              ),
              const SizedBox(height: 20),
              const Text(
                'OMEGOD',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF9D4EDD),
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(height: 20),
              const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF9D4EDD)),
              ),
            ],
          ),
        ),
      );
    }

    // Carrega a tela real com os parâmetros exigidos de forma segura
    return const GameGuideScreen(
      psnId: 'Omegod_User',
      gameId: 'omega_game_01',
    );
  }
}
