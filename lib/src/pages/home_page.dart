import 'package:flutter/material.dart';

import 'package:movies_app/src/services/movie_service.dart';
import 'package:movies_app/src/widgets/swiper_card.dart';

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
            _swiperCards(),
            _footer()
          ],
        )
      ),
    );
  }

  Widget _swiperCards() {
    return FutureBuilder(
      future: this.moviesService.getNowPlaying(),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if (snapshot.hasData) {
          return CardSwiper(movies: snapshot.data);
        } else {
          return Container(
            height: 350.0,
            child: Center(
              child: CircularProgressIndicator()
            ),
          );
        }
      },
    );
  }

  Widget _footer() {

    // Test Get Populars
    this.moviesService.getPopulars();

    return Container(
      child: Column(
        children: <Widget>[
          Text('Footer')
        ],
      ),
    );
  }
}
