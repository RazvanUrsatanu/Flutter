part of models;

abstract class AppState implements Built<AppState, AppStateBuilder> {
  factory AppState([void Function(AppStateBuilder)? updates]) = _$AppState;

  factory AppState.initialState() {
    return AppState((AppStateBuilder b) {
      b
        ..isLoading = false
        ..page = 1;
    });
  }

  factory AppState.fromJson(dynamic json) {
    return serializers.deserializeWith(serializer, json)!;
  }

  AppState._();

  BuiltList<Review> get reviews;

  AppUser? get user;

  BuiltList<Movie> get movies;

  bool get isLoading;

  int? get selectedMovie;

  int get page;

  Map<String, dynamic> get json => serializers.serializeWith(serializer, this)! as Map<String, dynamic>;

  static Serializer<AppState> get serializer => _$appStateSerializer;
}
