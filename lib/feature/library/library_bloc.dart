import 'dart:async';

import 'package:flayer/feature/bloc.dart';
import 'package:flayer/services/songs_finder.dart';
import 'package:rxdart/rxdart.dart';

class LibraryBloc extends Bloc {
  LibraryBloc(this._songsFinder);

  final SongsFinder _songsFinder;

  final _fetchedArtists = BehaviorSubject<List<Artist>>();
  final _fetchedAlbums = BehaviorSubject<List<Album>>();
  final _fetchedSongs = BehaviorSubject<List<Song>>();
  final _subscriptions = <StreamSubscription>[];

  Stream<List<Artist>> get artists => _fetchedArtists;
  Stream<List<Album>> get albums => _fetchedAlbums;
  Stream<List<Song>> get songs => _fetchedSongs;

  @override
  void dispose() {
    _subscriptions.forEach((sub) => sub.cancel());
    _fetchedArtists.close();
    _fetchedAlbums.close();
    _fetchedSongs.close();
  }

  void fetchArtists() {
    final sub = _songsFinder
        .artists()
        .asStream()
        .listen(_fetchedArtists.add, onError: _fetchedArtists.addError)
          ..onError(onError);

    _subscriptions.add(sub);
  }

  void fetchAlbums() {
    final sub = _songsFinder
        .albums()
        .asStream()
        .listen(_fetchedAlbums.add, onError: _fetchedAlbums.addError)
          ..onError(onError);

    _subscriptions.add(sub);
  }

  void fetchSongs() {
    final sub = _songsFinder
        .songs()
        .asStream()
        .listen(_fetchedSongs.add, onError: _fetchedSongs.addError)
          ..onError(onError);
    
    _subscriptions.add(sub);
  }
}
