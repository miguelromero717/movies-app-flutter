import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:movies_app/src/common/constants.dart' as Constants;
import 'package:movies_app/src/model/movie.dart';
import 'package:movies_app/src/model/movies.dart';

class MoviesService {

  Future<List<Movie>> _processResponse(Uri url) async {
    final resp = await http.get(url);
    final decodeData = json.decode(resp.body);

    final movies = Movies.fromJsonList(decodeData['results']);

    // Test Service Movies
    print(movies.items[0].title);

    return movies.items;
  }

  Future<List<Movie>> getNowPlaying() async {
    final url = Uri.https(Constants.URL, Constants.ROUTES['now_playing'], {
      'api_key': Constants.API_KEY,
      'language': Constants.LANGUAGE
    });

    return await _processResponse(url);
  }
}
