import 'package:audioplayers/audioplayers.dart';
import '../models/sounds.dart';

class SoundPlayer {
  final AudioPlayer _audioPlayer = AudioPlayer();

  Future<void> playSound(Sounds sound) async {
    _audioPlayer.setSourceAsset(sound.name);
    return await _audioPlayer.resume();
  }
}
