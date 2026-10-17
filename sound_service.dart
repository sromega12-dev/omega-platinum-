class SoundService {
  static final SoundService _instance = SoundService._internal();
  factory SoundService() => _instance;
  SoundService._internal();

  Future<void> init() async {}

  Future<void> playTrophySound() async {
    print('Som de troféu executado em modo silencioso');
  }

  // Compatibilidade com o game_guide_screen.dart
  static Future<void> playTrophyDing() async {
    print('Som playTrophyDing executado em modo silencioso');
  }
}
