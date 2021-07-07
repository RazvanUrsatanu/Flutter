import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:movies_redux/src/models/serializers.dart';

part 'movie.g.dart';

abstract class Movie implements Built<Movie, MovieBuilder> {
  factory Movie([void Function(MovieBuilder)? updates]) = _$Movie;

  factory Movie.fromJson(Map<String, dynamic> json) {
    return serializers.deserializeWith(serializer, json) as Movie;
  }

  Movie._();

  String get title;

  Map<String, dynamic> get json => serializers.serializeWith(serializer, this) as Map<String, dynamic>;

  static Serializer<Movie> get serializer => _$movieSerializer;
}
