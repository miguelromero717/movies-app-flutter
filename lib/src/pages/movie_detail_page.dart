import 'package:flutter/material.dart';

import 'package:movies_app/src/common/constants.dart' as Constants;

import 'package:movies_app/src/model/actor.dart';
import 'package:movies_app/src/model/movie.dart';
import 'package:movies_app/src/services/movie_service.dart';

class MovieDetail extends StatelessWidget {

  final moviesService = MoviesService();

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
          _description(movie),
          _cast(movie),
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
          placeholder: AssetImage(Constants.NO_IMAGE),
          fadeInDuration: Duration(milliseconds: 100),
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
          Hero(
            tag: movie.uniqueId,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Image(
                image: NetworkImage(movie.getPosterImage()),
                height: 150.0,
              ),
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

  Widget _cast(Movie movie) {
    return FutureBuilder(
      future: moviesService.getCast(movie.id.toString()),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if(snapshot.hasData){
          return _castPageView(snapshot.data);
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }

  Widget _castPageView(List<Actor> actors) {
    return SizedBox(
      height: 200.0,
      child: PageView.builder(
        controller: PageController(
          initialPage: 1,
          viewportFraction: 0.3
        ),
        itemCount: actors.length,
        itemBuilder: (context, i) => _cardActor(actors[i]),
      )
    );
  }

  Widget _cardActor(Actor actor) {
    return Container(
      child: Column(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: FadeInImage(
              height: 150.0,
              image: NetworkImage(actor.getProfileImage()),
              placeholder: AssetImage(Constants.LOADING_IMAGE),
              fadeInDuration: Duration(milliseconds: 100),
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 10.0,),
          Text(
            actor.name,
            overflow: TextOverflow.ellipsis
          )
        ],
      ),
    );
  }
}
