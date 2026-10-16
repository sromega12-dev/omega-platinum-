import 'package:audioplayers/audioplayers.dart';

class SoundService {
  static final AudioPlayer _player = AudioPlayer();

  static Future<void> playTrophyDing() async {
    try {
      await _player.stop();
      await _player.play(AssetSource('sounds/trophy_ding.mp3'));
    } catch (e) {
      // Tratar exceção de áudio se necessário
    }
  }
}
