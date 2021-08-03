import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart';
import 'package:movies_redux/src/models/index.dart';

class MovieApi {
  MovieApi({required Client client, required FirebaseFirestore firestore})
      : _client = client,
        _firestore = firestore;
  final Client _client;
  final FirebaseFirestore _firestore;

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

  Future<void> createReview(String comment, String uid, int movieId) async {
    final DocumentReference<Map<String, dynamic>> ref = _firestore.collection('reviews').doc();
    final Review review = Review((ReviewBuilder b) {
      b
        ..id = ref.id
        ..uid = uid
        ..comment = comment
        ..movieId = movieId;
    });
    await ref.set(review.json);
  }

  Future<List<Review>> getReviews(int movieId) async {
    final QuerySnapshot<Map<String, dynamic>> snapshot =
        await _firestore.collection('reviews').where('movieId', isEqualTo: movieId).get();

    return snapshot.docs.map((QueryDocumentSnapshot<Map<String, dynamic>> doc) => Review.fromJson(doc.data())).toList();
  }
}
