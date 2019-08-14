import 'package:flayer/feature/library/library_bloc.dart';
import 'package:flayer/feature/search_music/search_bloc.dart';
import 'package:flayer/services/songs_finder.dart';
import 'package:flayer/services_impl/android_songs_finder.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:kiwi/kiwi.dart';

final Container c = Container();

_services() {
  c.registerFactory((c) => FlutterAudioQuery());
  c.registerSingleton<SongsFinder, AndroidSongsFinder>((c) => AndroidSongsFinder(c()));
}

_blocs() {
  c.registerFactory((c) => SearchBloc(c()));
  c.registerFactory((c) => LibraryBloc(c()));
}

setupDI() async {
  _services();
  _blocs();
}

inject<T>() => c<T>();
