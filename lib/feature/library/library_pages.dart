import 'package:flayer/feature/library/library_bloc.dart';
import 'package:flayer/services/songs_finder.dart';
import 'package:flayer/utils/custom_hooks.dart';
import 'package:flutter/material.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';

part 'library_pages.g.dart';

@hwidget
Widget libraryTab() {
  final tickerProvider = useSingleTickerProvider();
  final tabController =
      useMemoized(() => TabController(length: 3, vsync: tickerProvider));

  final tabs = [ArtistsListPage(), AlbumsListPage(), SongsListPage()];

  return Scaffold(
    appBar: AppBar(
      flexibleSpace: SafeArea(
        child: Container(
          color: Colors.blueAccent,
          height: kToolbarHeight,
          child: TabBar(
            controller: tabController,
            tabs: [
              Tab(text: 'Artists'),
              Tab(text: 'Albums'),
              Tab(text: 'Songs'),
            ],
          ),
        ),
      ),
    ),
    body: TabBarView(
      controller: tabController,
      children: tabs,
    ),
  );
}

@widget
Widget libraryPage(BuildContext context) {
  return Column(
    children: <Widget>[
      ListTile(
        trailing: Icon(Icons.person_outline),
        title: Text('Artists'),
        onTap: () => Navigator.of(context).pushNamed('/artists'),
      ),
      ListTile(
        trailing: Icon(Icons.album),
        title: Text('Albums'),
      ),
      ListTile(
        trailing: Icon(Icons.music_note),
        title: Text('Songs'),
      ),
    ],
  );
}

Widget _musicItemsList<T>({
  List<T> data,
  String emptyMessage,
  Widget Function(BuildContext, int) builder,
}) {
  if (data == null) {
    return Center(child: CircularProgressIndicator());
  } else if (data.isEmpty) {
    return Center(child: Text(emptyMessage));
  } else {
    return ListView.builder(itemCount: data.length, itemBuilder: builder);
  }
}

@hwidget
Widget artistsListPage() {
  final libraryBloc = useProvider<LibraryBloc>();
  final artists = useProvider<List<Artist>>();
  libraryBloc.fetchArtists();

  return _musicItemsList(
      data: artists,
      emptyMessage: 'No artists found in your library',
      builder: (context, index) {
        return ListTile(
          leading: Icon(Icons.people_outline),
          title: Text(artists[index].name),
        );
      });
}

@hwidget
Widget albumsListPage() {
  final libraryBloc = useProvider<LibraryBloc>();
  final albums = useProvider<List<Album>>();
  libraryBloc.fetchAlbums();

  return _musicItemsList(
      data: albums,
      emptyMessage: 'No albums found in your library',
      builder: (context, index) {
        return ListTile(
          leading: Icon(Icons.album),
          title: Text(albums[index].name),
          subtitle: Text(albums[index].artistName),
        );
      });
}

@hwidget
Widget songsListPage() {
  final libraryBloc = useProvider<LibraryBloc>();
  final songs = useProvider<List<Song>>();
  libraryBloc.fetchSongs();  

  return _musicItemsList(
      data: songs,
      emptyMessage: 'No songs found in your library',
      builder: (context, index) {
        return ListTile(
          leading: Icon(Icons.music_note),
          title: Text(songs[index].name),
          subtitle: Text(songs[index].artist),
        );
      });
}
