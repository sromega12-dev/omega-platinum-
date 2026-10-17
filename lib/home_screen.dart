import 'package:flutter/material.dart';
import 'platinum_gallery_tab.dart';
import 'game_search_screen.dart';
import 'game_sedeer.dart';

class HomeScreen extends StatefulWidget {
  final String psnId;
  const HomeScreen({Key? key, required this.psnId}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  static const Color backgroundColor = Color(0xFF0A0A0C);
  static const Color primaryPurple = Color(0xFF9D4EDD);
  static const Color surfaceDark = Color(0xFF141419);
  static const Color textMuted = Color(0xFFA0A0AB);

  // Configurações e preferências
  bool _soundEffects = true;
  bool _notifications = true;
  bool _darkOledTheme = true;

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    // Lista de abas principais com o psnId repassado corretamente
    _pages = [
      PlatinumGalleryTab(psnId: widget.psnId), // Perfil & Rank Omegod
      GameSearchScreen(psnId: widget.psnId),    // Pesquisa de Guias
      _buildSettingsTab(),                      // Ajustes
    ];
  }

  Widget _buildSettingsTab() {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: surfaceDark,
        title: const Text('Configurações', style: TextStyle(color: Colors.white, fontSize: 18)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          SwitchListTile(
            activeColor: primaryPurple,
            title: const Text('Efeitos Sonoros ("Trophy Ding")', style: TextStyle(color: Colors.white)),
            subtitle: const Text('Tocar som ao marcar troféu como concluído', style: TextStyle(color: textMuted, fontSize: 12)),
            value: _soundEffects,
            onChanged: (val) => setState(() => _soundEffects = val),
          ),
          const Divider(color: surfaceDark),
          SwitchListTile(
            activeColor: primaryPurple,
            title: const Text('Notificações de Guias e Dicas', style: TextStyle(color: Colors.white)),
            subtitle: const Text('Receber alertas de novos guias de platinas', style: TextStyle(color: textMuted, fontSize: 12)),
            value: _notifications,
            onChanged: (val) => setState(() => _notifications = val),
          ),
          const Divider(color: surfaceDark),
          SwitchListTile(
            activeColor: primaryPurple,
            title: const Text('Modo Dark OLED', style: TextStyle(color: Colors.white)),
            subtitle: const Text('Fundo preto puro para economia de bateria', style: TextStyle(color: textMuted, fontSize: 12)),
            value: _darkOledTheme,
            onChanged: (val) => setState(() => _darkOledTheme = val),
          ),
          const Divider(color: surfaceDark),
          const SizedBox(height: 12),
          
          // Botão para popular os guias iniciais no Firestore
          ListTile(
            tileColor: surfaceDark,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(color: primaryPurple.withOpacity(0.4)),
            ),
            leading: const Icon(Icons.cloud_upload, color: primaryPurple),
            title: const Text(
              'Carregar Guias Iniciais no Firestore',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            subtitle: const Text(
              'Popula a nuvem com Elden Ring, Bloodborne, Silent Hill 2, etc.',
              style: TextStyle(color: textMuted, fontSize: 12),
            ),
            onTap: () => GameSeeder().seedAllGuides(context),
          ),
        ],
      
