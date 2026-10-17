import 'package:flutter/material.dart';
import 'platinum_gallery_tab.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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
        scaffoldBackgroundColor: const Color(0xFF0A0A0C),
        colorScheme: const ColorScheme.dark(primary: purple, surface: Color(0xFF141419)),
        appBarTheme: const AppBarTheme(backgroundColor: Color(0xFF141419), foregroundColor: Colors.white),
        useMaterial3: true,
      ),
      home: const OmegaHomeScreen(),
    );
  }
}

class OmegaHomeScreen extends StatefulWidget {
  const OmegaHomeScreen({super.key});

  @override
  State<OmegaHomeScreen> createState() => _OmegaHomeScreenState();
}

class _OmegaHomeScreenState extends State<OmegaHomeScreen> {
  int _selectedIndex = 0;
  bool _soundEffects = true;
  bool _notifications = true;
  bool _oled = true;

  static const purple = Color(0xFF9D4EDD);
  static const muted = Color(0xFFA0A0AB);

  final List<Map<String, dynamic>> _games = [
    {'id': 'divinity', 'title': 'Divinity: Original Sin 2', 'difficulty': '9/10', 'time': '120–150 horas', 'items': ['Garras do Devorador', 'Passos do Devorador', 'Coroa do Devorador']},
    {'id': 'elden', 'title': 'Elden Ring', 'difficulty': '6/10', 'time': '80–120 horas', 'items': ['Conseguir todos os finais', 'Obter armamentos lendários', 'Obter cinzas lendárias']},
    {'id': 'bloodborne', 'title': 'Bloodborne', 'difficulty': '7/10', 'time': '50–70 horas', 'items': ['Obter todas as armas', 'Concluir o final da infância', 'Derrotar a Rainha Pthumeriana']},
    {'id': 'silent_hill_2', 'title': 'Silent Hill 2 Remake', 'difficulty': '5/10', 'time': '25–35 horas', 'items': ['Encontrar todos os memorandos', 'Resolver os enigmas', 'Conseguir os finais']},
  ];
  final Map<String, Set<String>> _completed = {};

  @override
  Widget build(BuildContext context) {
    final pages = <Widget>[
      _buildDashboard(),
      _buildGuides(),
      const PlatinumGalleryTab(),
      _buildSettings(),
    ];
    return Scaffold(
      body: IndexedStack(index: _selectedIndex, children: pages),
      bottomNavigationBar: NavigationBar(
        backgroundColor: const Color(0xFF141419),
        indicatorColor: purple.withOpacity(0.22),
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) => setState(() => _selectedIndex = index),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'Início'),
          NavigationDestination(icon: Icon(Icons.menu_book_outlined), selectedIcon: Icon(Icons.menu_book), label: 'Guias'),
          NavigationDestination(icon: Icon(Icons.emoji_events_outlined), selectedIcon: Icon(Icons.emoji_events), label: 'Platinas'),
          NavigationDestination(icon: Icon(Icons.settings_outlined), selectedIcon: Icon(Icons.settings), label: 'Ajustes'),
        ],
      ),
    );
  }

  Widget _buildDashboard() {
    return Scaffold(
      appBar: AppBar(title: const Text('OMEGA PLATINUM', style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.2)), centerTitle: true),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const SizedBox(height: 12),
          Center(child: Container(padding: const EdgeInsets.all(22), decoration: BoxDecoration(shape: BoxShape.circle, color: purple.withOpacity(0.15), border: Border.all(color: purple, width: 2)), child: const Icon(Icons.emoji_events, size: 64, color: purple))),
          const SizedBox(height: 20),
          const Text('SUA JORNADA RUMO À PLATINA', textAlign: TextAlign.center, style: TextStyle(color: muted, letterSpacing: 1.3, fontSize: 13)),
          const SizedBox(height: 8),
          const Text('OMEGA PLATINUM', textAlign: TextAlign.center, style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold, color: purple)),
          const SizedBox(height: 28),
          _dashboardCard(Icons.menu_book, 'Guia de Troféus', 'Consulte guias e acompanhe seu progresso', () => setState(() => _selectedIndex = 1)),
          const SizedBox(height: 12),
          _dashboardCard(Icons.emoji_events, 'Platinas Conquistadas', 'Veja a galeria de jogos concluídos', () => setState(() => _selectedIndex = 2)),
          const SizedBox(height: 12),
          _dashboardCard(Icons.settings, 'Configurações', 'Personalize as opções do aplicativo', () => setState(() => _selectedIndex = 3)),
          const SizedBox(height: 20),
          const Text('Nota: o progresso desta versão é mantido apenas enquanto o aplicativo está aberto. A sincronização online precisa de configuração do Firebase.', textAlign: TextAlign.center, style: TextStyle(color: muted, fontSize: 12)),
        ],
      ),
    );
  }

  Widget _dashboardCard(IconData icon, String title, String subtitle, VoidCallback onTap) => Card(
    color: const Color(0xFF16161A), clipBehavior: Clip.antiAlias,
    child: ListTile(leading: Icon(icon, color: purple, size: 30), title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)), subtitle: Text(subtitle, style: const TextStyle(color: muted, fontSize: 12)), trailing: const Icon(Icons.arrow_forward_ios, color: purple, size: 16), onTap: onTap),
  );

  Widget _buildGuides() {
    return Scaffold(
      appBar: AppBar(title: const Text('Guias de Troféus')),
      body: ListView.builder(
        padding: const EdgeInsets.all(12), itemCount: _games.length,
        itemBuilder: (context, index) {
          final game = _games[index];
          final done = _completed[game['id']]?.length ?? 0;
          final total = (game['items'] as List).length;
          return Card(color: const Color(0xFF16161A), child: ListTile(
            leading: const Icon(Icons.sports_esports, color: purple, size: 30),
            title: Text(game['title'], style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text('Dificuldade ${game['difficulty']} • ${game['time']}\nProgresso: $done/$total itens', style: const TextStyle(color: muted, height: 1.5)),
            isThreeLine: true, trailing: const Icon(Icons.chevron_right, color: purple),
            onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => _GuideDetailScreen(game: game, completed: _completed.putIfAbsent(game['id'] as String, () => <String>{}), onChanged: () => setState(() {})))),
          ));
        },
      ),
    );
  }

  Widget _buildSettings() => Scaffold(
    appBar: AppBar(title: const Text('Configurações')),
    body: ListView(children: [
      SwitchListTile(value: _soundEffects, activeColor: purple, title: const Text('Efeitos sonoros'), subtitle: const Text('Som ao marcar um item'), onChanged: (v) => setState(() => _soundEffects = v)),
      const Divider(color: Color(0xFF292932)),
      SwitchListTile(value: _notifications, activeColor: purple, title: const Text('Notificações'), subtitle: const Text('Alertas de novos guias'), onChanged: (v) => setState(() => _notifications = v)),
      const Divider(color: Color(0xFF292932)),
      SwitchListTile(value: _oled, activeColor: purple, title: const Text('Modo Dark OLED'), subtitle: const Text('Usar fundo escuro'), onChanged: (v) => setState(() => _oled = v)),
      const Padding(padding: EdgeInsets.all(16), child: Text('As opções ficam ativas nesta sessão. Salvamento permanente ainda não está configurado.', style: TextStyle(color: muted, fontSize: 12))),
    ]),
  );
}

class _GuideDetailScreen extends StatefulWidget {
  final Map<String, dynamic> game;
  final Set<String> completed;
  final VoidCallback onChanged;
  const _GuideDetailScreen({required this.game, required this.completed, required this.onChanged});

  @override
  State<_GuideDetailScreen> createState() => _GuideDetailScreenState();
}

class _GuideDetailScreenState extends State<_GuideDetailScreen> {
  static const purple = Color(0xFF9D4EDD);
  static const muted = Color(0xFFA0A0AB);
  @override
  Widget build(BuildContext context) {
    final items = List<String>.from(widget.game['items'] as List);
    return Scaffold(
      appBar: AppBar(title: Text(widget.game['title'] as String)),
      body: ListView(padding: const EdgeInsets.all(16), children: [
        Text('Checklist de troféus', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(height: 6),
        const Text('Marque os itens conforme avança. Estes são itens de exemplo, não um guia completo.', style: TextStyle(color: muted, fontSize: 12)),
        const SizedBox(height: 12),
        LinearProgressIndicator(value: items.isEmpty ? 0 : widget.completed.length / items.length, color: purple, backgroundColor: const Color(0xFF292932)),
        const SizedBox(height: 12),
        for (final item in items)
          Card(color: const Color(0xFF16161A), child: CheckboxListTile(
            activeColor: purple, value: widget.completed.contains(item), title: Text(item, style: TextStyle(decoration: widget.completed.contains(item) ? TextDecoration.lineThrough : null)),
            onChanged: (value) => setState(() { if (value == true) { widget.completed.add(item); } else { widget.completed.remove(item); } widget.onChanged(); }),
          )),
      ]),
    );
  }
}
