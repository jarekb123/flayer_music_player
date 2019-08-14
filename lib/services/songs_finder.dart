import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class MusicItem implements Equatable {
  String get name;
}

class Song extends Equatable implements MusicItem {
  Song({
    @required this.name,
    @required this.artist,
    @required this.album,
    @required this.length,
    @required this.uri,
  }) : super([name, artist, album, length, uri]);

  final String name;
  final String artist;
  final String album;
  final Duration length;
  final String uri;
}

class Artist extends Equatable implements MusicItem {
  Artist({@required this.name}) : super([name]);

  final String name;
}

class Album extends Equatable implements MusicItem {
  Album({
    @required this.id,
    @required this.name,
    @required this.artistName,
    @required this.albumArtUri,
  }) : super([name, artistName, albumArtUri]);

  final String id;
  final String name;
  final String artistName;
  final String albumArtUri;
}

abstract class SongsFinder {
  /// Finds [MusicItem] in local database using provided [query]
  Future<List<MusicItem>> find(String query);

  // Fetch all
  Future<List<Artist>> artists();
  Future<List<Album>> albums();
  Future<List<Song>> songs();

  // Fetch by
  Future<List<Album>> albumsOfArtist(Artist artist);
  Future<List<Song>> songsOfAlbum(Album album);
}
