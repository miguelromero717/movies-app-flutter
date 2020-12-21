import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import 'package:movies_app/src/common/constants.dart' as Constants;
import 'package:movies_app/src/model/movie.dart';

class CardSwiper extends StatelessWidget {

  final List<Movie> movies;

  CardSwiper({ @required this.movies });

  @override
  Widget build(BuildContext context) {

    final _screenSize = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.only(top: 10.0),
      child: Swiper(
        layout: SwiperLayout.STACK,
        itemCount: this.movies.length,
        itemWidth: _screenSize.width * 0.7,
        itemHeight: _screenSize.height * 0.5,
        itemBuilder: (BuildContext context, int index) {
          this.movies[index].uniqueId = this.movies[index].id.toString() + '-swiper';
          return GestureDetector(
            onTap: () => Navigator.pushNamed(context, 'detail', arguments: this.movies[index]),
            child: Hero(
              tag: this.movies[index].uniqueId,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: FadeInImage(
                  image: NetworkImage(this.movies[index].getPosterImage()),
                  placeholder: AssetImage(Constants.NO_IMAGE),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}