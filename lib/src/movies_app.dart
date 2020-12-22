import 'package:flutter/material.dart';
import 'package:movies_app/src/pages/home_page.dart';
import 'package:movies_app/src/pages/movie_detail_page.dart';

class MoviesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movies App',
      initialRoute: '/',
      routes: {
        '/': (BuildContext context) => HomePage(),
        'detail': (BuildContext context) => MovieDetail()
      },
    );
  }
}
