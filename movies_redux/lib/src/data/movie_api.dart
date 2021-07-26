import 'dart:convert';

import 'package:http/http.dart';
import 'package:movies_redux/src/models/index.dart';

class MovieApi {
  MovieApi({required Client client}) : _client = client;
  final Client _client;

  Future<List<Movie>> getMovie(int page) async {
    final Uri url = Uri(
      scheme: 'https',
      host: 'yts.mx',
      pathSegments: <String>['api', 'v2', 'list_movies.json'],
      queryParameters: <String, String>{
        'limit': '20',
        'page': '$page',
      },
    );
    final Response response = await _client.get(url);
    if (response.statusCode >= 300) {
      throw StateError(response.body);
    }
    return (jsonDecode(response.body)['data']['movies'] as List<dynamic>)
        .map((dynamic movieJson) => Movie.fromJson(movieJson as Map<String, dynamic>))
        .toList();
  }
}
