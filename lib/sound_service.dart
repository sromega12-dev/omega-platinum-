// sound_service.dart - Versão segura sem dependências externas
class SoundService {
  static final SoundService _instance = SoundService._internal();
  factory SoundService() => _instance;
  SoundService._internal();

  Future<void> init() async {
    // Inicialização silenciosa
  }

  Future<void> playTrophySound() async {
    // Execução silenciosa temporária para evitar erros de compilação
    print('Trophy sound played (silent mode)');
  }
}
