import 'package:flutter/material.dart';

import 'package:movies_app/src/common/constants.dart' as Constants;
import 'package:movies_app/src/services/movie_service.dart';
import 'package:movies_app/src/widgets/card_swiper.dart';
import 'package:movies_app/src/widgets/movies_horizontal.dart';

class HomePage extends StatelessWidget {

  final moviesService = MoviesService();

  @override
  Widget build(BuildContext context) {

    moviesService.getPopulars();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigoAccent,
        title: Text('Movies App'),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _swiperCards(),
            _footer(context)
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

  Widget _footer(BuildContext context) {

    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 20.0),
            child: Text(Constants.LABELS['popular'], style: Theme.of(context).textTheme.headline6),
          ),
          SizedBox(height: 5.0),
          StreamBuilder(
            stream: this.moviesService.popularMoviesStream,
            builder: (BuildContext context, AsyncSnapshot<List> asyncSnapshot) {
              if (asyncSnapshot.hasData) {
                return MoviesHorizontal(
                  movies: asyncSnapshot.data,
                  nextPage: this.moviesService.getPopulars,
                );
              } else {
                return CircularProgressIndicator();
              }
            },
          )
        ],
      ),
    );
  }
}
