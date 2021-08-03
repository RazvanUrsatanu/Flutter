part of models;

abstract class Movie implements Built<Movie, MovieBuilder> {
  factory Movie([void Function(MovieBuilder)? updates]) = _$Movie;

  factory Movie.fromJson(Map<String, dynamic> json) {
    return serializers.deserializeWith(serializer, json)!;
  }

  Movie._();

  String get title;

  int get id;

  @BuiltValueField(wireName: 'medium_cover_image')
  String get image;

  String get summary;

  @BuiltValueField(wireName: 'large_cover_image')
  String get largeImage;

  Map<String, dynamic> get json => serializers.serializeWith(serializer, this)! as Map<String, dynamic>;

  static Serializer<Movie> get serializer => _$movieSerializer;
}
