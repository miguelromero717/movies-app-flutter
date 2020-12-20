import 'package:flutter/material.dart';

import 'package:movies_app/src/common/constants.dart' as Constants;
import 'package:movies_app/src/model/movie.dart';

class MoviesHorizontal extends StatelessWidget {
  final List<Movie> movies;

  MoviesHorizontal({@required this.movies});

  final _pageController = new PageController(
    initialPage: 1,
    viewportFraction: 0.3
  );

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    return Container(
      height: _screenSize.height * 0.3,
      child: PageView.builder(
        pageSnapping: false,
        controller: _pageController,
        itemCount: this.movies.length,
        itemBuilder: (context, i) => _card(context, this.movies[i]),
      )
    );
  }

  Widget _card(BuildContext context, Movie movie) {
    return Container(
      margin: EdgeInsets.only(right: 15.0),
      child: Column(
        children: <Widget>[
          Hero(
            tag: movie.originalTitle,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                image: NetworkImage(movie.getPosterImage()),
                placeholder: AssetImage(Constants.NO_IMAGE),
                fit: BoxFit.cover,
              ),
            )
          ),
          SizedBox(height: 5.0,),
          Text(
            movie.title,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.caption,
          )
        ],
      ),
    );
  }

}
