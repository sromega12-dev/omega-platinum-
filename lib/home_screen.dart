import 'package:flutter/material.dart';
import 'platinum_gallery_tab.dart';
import 'game_search_screen.dart';

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

  // Ajustes de preferências
  bool _soundEffects = true;
  bool _notifications = true;
  bool _darkOledTheme = true;

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      const PlatinumGalleryTab(),
      GameSearchScreen(psnId: widget.psnId), // Barra de Pesquisa Dinâmica!
      _buildSettingsTab(),
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
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: surfaceDark,
        selectedItemColor: primaryPurple,
        unselectedItemColor: textMuted,
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.emoji_events),
            label: 'Platinas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Guias',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Ajustes',
          ),
        ],
      ),
    );
  }
}
