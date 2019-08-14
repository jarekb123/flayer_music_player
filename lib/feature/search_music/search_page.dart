import 'package:flayer/feature/search_music/search_bloc.dart';
import 'package:flayer/services/songs_finder.dart';
import 'package:flayer/utils/custom_hooks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:provider/provider.dart';

part 'search_page.g.dart';

@hwidget
Widget searchPage() {
  final SearchBloc searchBloc = useProvider();
  final isSearching = useState(false);

  search(String query) {
    searchBloc.searchMusic(query);
  }

  TextField searchField() {
    return TextField(
      decoration: InputDecoration(hintText: 'Search...'),
      textInputAction: TextInputAction.search,
      onChanged: search,
    );
  }

  final appBar = AppBar(
    leading: IconButton(
      icon: Icon(!isSearching.value ? Icons.search : Icons.close),
      onPressed: () => isSearching.value = !isSearching.value,
    ),
    title: isSearching.value ? searchField() : null,
  );

  return Scaffold(
    appBar: appBar,
    body: StreamProvider.value(
      value: searchBloc.foundItems,
      child: SearchResultsList(),
    ),
  );
}

@hwidget
Widget searchResultsList() {
  final List<MusicItem> results = useProvider();

  if (results == null) {
    return Container();
  } else if (results.isEmpty) {
    return Center(child: Text('No results found...'));
  } else {
    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (BuildContext context, int index) {
        return _ResultItem(results[index]);
      },
    );
  }
}

@widget
Widget _resultItem(MusicItem musicItem) {
  if (musicItem is Artist) {
    return ListTile(
      leading: Icon(Icons.person),
      title: Text(musicItem.name),
    );
  } else if (musicItem is Album) {
    return ListTile(
      leading: Icon(Icons.album),
      title: Text('${musicItem.artistName} - ${musicItem.name}'),
    );
  } else if (musicItem is Song) {
    return ListTile(
      leading: Icon(Icons.music_note),
      title: Text('${musicItem.artist} - ${musicItem.name}'),
    );
  } else {
    throw StateError('Unexpected state $musicItem');
  }
}
