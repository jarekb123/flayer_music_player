import 'package:flayer/di.dart';
import 'package:flayer/feature/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';

part 'main.g.dart';

Future main() async {
  await setupDI();

  runApp(MyApp());
}

@widget
Widget myApp() {
  return MaterialApp(
    home: HomePage(),
  );
}
