import 'dart:async';

import 'package:flayer/feature/bloc.dart';
import 'package:flayer/services/songs_finder.dart';
import 'package:rxdart/rxdart.dart';

class SearchBloc extends Bloc {
  SearchBloc(this._songsFinder);

  final SongsFinder _songsFinder;
  final _foundItems = BehaviorSubject<List<MusicItem>>.seeded([]);

  StreamSubscription _searchSubscription;

  Stream<List<MusicItem>> get foundItems => _foundItems;

  @override
  void dispose() {
    _cancelSearch();
    _foundItems.close();
  }

  void searchMusic(String query) {
    _cancelSearch(); // cancel previous request
    if (query.isEmpty) {
      _foundItems.add([]);
      return;
    }
    _searchSubscription = _songsFinder
        .find(query)
        .asStream()
        .listen(_foundItems.add, onError: _foundItems.addError)
          ..onError(onError);
  }

  void _cancelSearch() => _searchSubscription?.cancel();
}
