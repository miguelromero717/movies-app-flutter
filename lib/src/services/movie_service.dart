import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:movies_app/src/common/constants.dart' as Constants;
import 'package:movies_app/src/model/movie.dart';
import 'package:movies_app/src/model/movies.dart';

class MoviesService {

  int _popularPage = 0;
  bool _loading = false;

  List<Movie> _popularMovies = new List();

  final _popularMoviesStreamController = StreamController<List<Movie>>.broadcast();

  Function(List<Movie>) get popularMoviesSink => _popularMoviesStreamController.sink.add;

  Stream<List<Movie>> get popularMoviesStream => _popularMoviesStreamController.stream;

  void disposeStreams() {
    _popularMoviesStreamController?.close();
  }

  Future<List<Movie>> _processResponse(Uri url) async {
    final resp = await http.get(url);
    final decodeData = json.decode(resp.body);

    final movies = Movies.fromJsonList(decodeData['results']);

    return movies.items;
  }

  Future<List<Movie>> getNowPlaying() async {
    final url = Uri.https(Constants.URL, Constants.ROUTES['now_playing'], {
      'api_key': Constants.API_KEY,
      'language': Constants.LANGUAGE
    });

    return await _processResponse(url);
  }

  Future<List<Movie>> getPopulars() async {

    if (_loading) return [];

    _loading = true;

    _popularPage++;

    final url = Uri.https(Constants.URL, Constants.ROUTES['populars'], {
      'api_key': Constants.API_KEY,
      'language': Constants.LANGUAGE,
      'page': _popularPage.toString()
    });

    final response = await _processResponse(url);

    _popularMovies.addAll(response);
    popularMoviesSink(_popularMovies);

    _loading = false;

    return response;
  }
}
