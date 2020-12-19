import 'package:flutter/material.dart';

import 'package:movies_app/src/services/movie_service.dart';

class HomePage extends StatelessWidget {

  final moviesService = MoviesService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movies App'),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _swiperCards()
          ],
        )
      ),
    );
  }

  Widget _swiperCards() {

    // Test Service Movies
    this.moviesService.getNowPlaying();

    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Movie App'),
            ],
          ),
        ],
      ),
    );
  }
}
