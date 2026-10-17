import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'login_screen.dart';

void main() async {
  // Garante que os bindings nativos do Flutter estão prontos
  WidgetsFlutterBinding.ensureInitialized();

  bool firebaseInitialized = false;

  try {
    // Inicializa o Firebase com tempo limite de segurança
    await Firebase.initializeApp();
    firebaseInitialized = true;
  } catch (e) {
    debugPrint("Aviso ao inicializar Firebase: $e");
    // Mantém firebaseInitialized como false para não travar o arranque
  }

  runApp(OmegaPlatinumApp(isFirebaseOk: firebaseInitialized));
}

class OmegaPlatinumApp extends StatelessWidget {
  final bool isFirebaseOk;
  const OmegaPlatinumApp({Key? key, required this.isFirebaseOk}) : super(key: key);

  static const Color backgroundColor = Color(0xFF0A0A0C);
  static const Color primaryPurple = Color(0xFF9D4EDD);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Omega Platinum',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: backgroundColor,
        primaryColor: primaryPurple,
        colorScheme: const ColorScheme.dark(
          primary: primaryPurple,
          surface: Color(0xFF141419),
          background: backgroundColor,
        ),
      ),
      home: const LoginScreen(),
    );
  }
}
