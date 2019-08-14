import 'package:audio_service/audio_service.dart';
import 'package:audioplayer/audioplayer.dart';
import 'package:flayer/services/music_player.dart';

class AndroidMusicPlayer extends MusicPlayer {
  @override
  Future<bool> play(Track track) {
    
  }

  @override
  Future<void> pause() {
    // TODO: implement pause
    return null;
  }

  @override
  Future<void> playPlaylist(List<Track> playlist) {
    // TODO: implement playPlaylist
    return null;
  }

  @override
  Future<void> next() {
    // TODO: implement next
    return null;
  }

  @override
  Future<void> previous() {
    // TODO: implement previous
    return null;
  }

  @override
  Future<void> seekTo(Duration position) {
    // TODO: implement seekTo
    return null;
  }
}

class BackgroundAudioService {
  void play() => AudioService.play();
  void pause() => AudioService.pause();
}

void _backgroundAudioPlayerTask() {
  AudioPlayer audioPlayer = AudioPlayer();
  
}