import 'dart:convert';

import 'package:http/http.dart';
import 'package:movies_redux/src/models/movie.dart';

class MovieApi {
  MovieApi({required Client client}) : _client = client;
  final Client _client;

  Future<List<Movie>> getMovies() async {
    final Uri uri = Uri(
      scheme: 'https', //
      host: 'yts.mx',
      pathSegments: <String>['api', 'v2', 'list_movies.json'],
    );

    final Response response = await _client.get(uri);

    if (response.statusCode == 200) {
      final Map<dynamic, dynamic> responseBody = jsonDecode(response.body) as Map<dynamic, dynamic>;
      final Map<dynamic, dynamic> moviesData = responseBody['data'] as Map<dynamic, dynamic>;
      final List<dynamic> list = moviesData['movies'] as List<dynamic>;
      return list.map((dynamic json) => Movie.fromJson(json)).toList();
    }
  }
}
