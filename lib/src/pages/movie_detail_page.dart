import 'package:flutter/material.dart';
import 'package:movies_app/src/model/movie.dart';

class MovieDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Movie movie = ModalRoute.of(context).settings.arguments;

    return Scaffold(
        body: CustomScrollView(
      slivers: [
        _createAppBar(movie),
        SliverList(
            delegate: SliverChildListDelegate([
          SizedBox(
            height: 10.0,
          ),
          _posterTitle(context, movie),
          _description(movie)
        ]))
      ],
    ));
  }

  Widget _createAppBar(Movie movie) {
    return SliverAppBar(
      elevation: 2.0,
      backgroundColor: Colors.indigoAccent,
      expandedHeight: 200.0,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          movie.title,
          style: TextStyle(color: Colors.white, fontSize: 16.0),
        ),
        background: FadeInImage(
          image: NetworkImage(movie.getBackdropImage()),
          placeholder: AssetImage('assets/img/loading.gif'),
          fadeInDuration: Duration(milliseconds: 150),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _posterTitle(BuildContext context, Movie movie) {
    return Container(
      child: Row(
        children: [
          SizedBox(width: 20.0,),
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Image(
              image: NetworkImage(movie.getPosterImage()),
              height: 150.0,
            ),
          ),
          SizedBox(width: 20.0,),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(movie.title),
                Text(movie.originalTitle),
                Row(
                  children: [
                    Icon(Icons.star_border),
                    Text(movie.voteAverage.toString())
                  ],
                )
              ],
            )
          )
        ],
      ),
    );
  }

  Widget _description(Movie movie) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
      child: Text(
        movie.overview,
        textAlign: TextAlign.justify,
      ),
    );
  }
}
