import 'package:flutter/material.dart';
import 'package:summoner_viewer/cupertino_scaffold_nav.dart';
import 'package:summoner_viewer/home_page.dart';
import 'package:summoner_viewer/summoner_search/search_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: HomePage(),
      );
  }
}




