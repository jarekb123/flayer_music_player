import 'package:flayer/feature/bloc.dart';
import 'package:flayer/feature/library/library_bloc.dart';
import 'package:flayer/feature/library/library_pages.dart';
import 'package:flayer/feature/search_music/search_bloc.dart';
import 'package:flayer/feature/search_music/search_page.dart';
import 'package:flayer/utils/custom_hooks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:provider/provider.dart';

part 'home_page.g.dart';

@hwidget
Widget homePage() {
  final searchBloc = useBloc<SearchBloc>();
  final searchBlocProviders = <SingleChildCloneableWidget>[
    Provider.value(value: searchBloc),
    StreamProvider.value(value: searchBloc.foundItems),
  ];

  final libraryBloc = useBloc<LibraryBloc>();
  final libraryBlocProviders = <SingleChildCloneableWidget>[
    Provider.value(value: libraryBloc),
    StreamProvider.value(value: libraryBloc.artists),
    StreamProvider.value(value: libraryBloc.albums),
    StreamProvider.value(value: libraryBloc.songs),
  ];

  final navigatorKeys = useMemoized(
    () => [
      GlobalKey<NavigatorState>(debugLabel: 'SearchPage navigator'),
      GlobalKey<NavigatorState>(debugLabel: 'LibraryTab navigator'),
    ],
  );
  final currentPage = useState(0);

  final pages = [
    SearchPage(),
    LibraryTab(),
  ];

  return WillPopScope(
    onWillPop: () => navigatorKeys[currentPage.value].currentState.maybePop(),
    child: Scaffold(
      body: MultiProvider(
        providers: [
          ...searchBlocProviders,
          ...libraryBlocProviders,
        ],
        child: pages[currentPage.value],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentPage.value,
        onTap: (index) => currentPage.value = index,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.play_circle_outline),
            title: Text('Player'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.library_music),
            title: Text('Music Library'),
          ),
        ],
      ),
    ),
  );
}
