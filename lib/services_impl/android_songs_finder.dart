import 'package:flayer/services/songs_finder.dart';
import 'package:flayer/utils/collection_utils.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';

class AndroidSongsFinder implements SongsFinder {
  const AndroidSongsFinder(this._audioQuery);

  final FlutterAudioQuery _audioQuery;

  @override
  Future<List<MusicItem>> find(String query) async {
    final albums = await _audioQuery
        .searchAlbums(query: query)
        .then(mapList(albumInfoToAlbum));
    final artists = await _audioQuery
        .searchArtists(query: query)
        .then(mapList(artistInfoToArtist));
    final songs = await _audioQuery
        .searchSongs(query: query)
        .then(mapList(songInfoToSong));

    final items = [...albums, ...artists, ...songs]
      ..sort((item1, item2) => item1.name.compareTo(item2.name));

    return items.toList(growable: false);
  }

  @override
  Future<List<Album>> albums() =>
      _audioQuery.getAlbums().then(mapList(albumInfoToAlbum));

  @override
  Future<List<Artist>> artists() =>
      _audioQuery.getArtists().then(mapList(artistInfoToArtist));

  @override
  Future<List<Song>> songs() =>
      _audioQuery.getSongs().then(mapList(songInfoToSong));

  @override
  Future<List<Album>> albumsOfArtist(Artist artist) => _audioQuery
      .getAlbumsFromArtist(artist: artist.name)
      .then(mapList(albumInfoToAlbum));

  @override
  Future<List<Song>> songsOfAlbum(Album album) => _audioQuery
      .getSongsFromAlbum(albumId: album.id)
      .then(mapList(songInfoToSong));
}

Album albumInfoToAlbum(AlbumInfo albumInfo) => Album(
      id: albumInfo.id,
      name: albumInfo.title,
      artistName: albumInfo.artist,
      albumArtUri: albumInfo.albumArt,
    );

Artist artistInfoToArtist(ArtistInfo artistInfo) =>
    Artist(name: artistInfo.name);

Song songInfoToSong(SongInfo songInfo) => Song(
      name: songInfo.title,
      album: songInfo.album,
      artist: songInfo.album,
      uri: songInfo.filePath,
      length: Duration(milliseconds: int.parse(songInfo.duration)),
    );
