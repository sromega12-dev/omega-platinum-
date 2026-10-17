import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'login_screen.dart'; // ou a sua tela inicial original

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // PROTEÇÃO ESSENCIAL: Impede que o app congele na tela cinza se o Firebase falhar
  try {
    await Firebase.initializeApp();
  } catch (e) {
    debugPrint('Aviso de inicialização do Firebase: $e');
  }

  runApp(const OmegaPlatinumApp());
}

class OmegaPlatinumApp extends StatelessWidget {
  const OmegaPlatinumApp({super.key});

  @override
  Widget build(BuildContext context) {
    const purple = Color(0xFF9D4EDD);
    return MaterialApp(
      title: 'Omega Platinum',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0A0A0C), // Dark OLED
        colorScheme: const ColorScheme.dark(
          primary: purple,
          surface: Color(0xFF141419),
        ),
        useMaterial3: true,
      ),
      home: const LoginScreen(),
    );
  }
}
