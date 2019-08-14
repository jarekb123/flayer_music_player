import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Track extends Equatable {
  Track({
    @required this.id,
    @required this.uri,
    @required this.title,
    @required this.artist,
    @required this.album,
    @required this.duration,
    @required this.albumArtUri,
  }) : super([id, uri, title, artist, album, duration, albumArtUri]);

  final String id;
  final String uri;
  final String title;
  final String artist;
  final String album;
  final Duration duration;
  final String albumArtUri;
}

abstract class MusicPlayer {
  /// Returns [true] if provided [track] is playing
  Future<bool> play(Track track);

  /// Pauses current track
  Future<void> pause();

  Future<void> seekTo(Duration position);

  Future<void> playPlaylist(List<Track> playlist);

  /// Changes track to next from the provided playlist
  Future<void> next();

  /// Changes track to previous one from the provided playlist
  Future<void> previous();
}
