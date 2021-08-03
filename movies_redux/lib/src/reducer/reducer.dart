import 'package:movies_redux/src/actions/index.dart';
import 'package:movies_redux/src/models/index.dart';
import 'package:redux/redux.dart';

Reducer<AppState> reducer = combineReducers(<Reducer<AppState>>[
  TypedReducer<AppState, GetMovies>(_getMovies),
  TypedReducer<AppState, GetMoviesSuccessful>(_getMoviesSuccessful),
  TypedReducer<AppState, GetMoviesError>(_getMoviesError),
  TypedReducer<AppState, SelectMovie>(_selectedMovie),
  TypedReducer<AppState, RegisterSuccessful>(_registerSuccessful),
  TypedReducer<AppState, InitializeAppSuccessful>(_initializeAppSuccessful),
  TypedReducer<AppState, SignOutSuccessful>(_signOutSuccessful),
  TypedReducer<AppState, UpdateProfileUrlSuccessful>(_updateProfileUrlSuccessful),
  TypedReducer<AppState, GetReviewsSuccessful>(_getReviewSuccessful),
]);

AppState _getMovies(AppState state, GetMovies action) {
  return state.rebuild((AppStateBuilder b) {
    b.isLoading = true;
  });
}

AppState _getMoviesSuccessful(AppState state, GetMoviesSuccessful action) {
  return state.rebuild((AppStateBuilder b) => b
    ..isLoading = false
    ..page = state.page + 1
    ..movies.addAll(action.movies));
}

AppState _getMoviesError(AppState state, GetMoviesError action) {
  return state.rebuild((AppStateBuilder b) => b.isLoading = false);
}

AppState _selectedMovie(AppState state, SelectMovie action) {
  return state.rebuild((AppStateBuilder b) => b.selectedMovie = action.index);
}

AppState _registerSuccessful(AppState state, RegisterSuccessful action) {
  return state.rebuild((AppStateBuilder b) {
    b.user = action.user.toBuilder();
  });
}

AppState _initializeAppSuccessful(AppState state, InitializeAppSuccessful action) {
  return state.rebuild((AppStateBuilder b) {
    b.user = action.user?.toBuilder();
  });
}

AppState _signOutSuccessful(AppState state, SignOutSuccessful action) {
  return state.rebuild((AppStateBuilder b) {
    b.user = null;
  });
}

AppState _updateProfileUrlSuccessful(AppState state, UpdateProfileUrlSuccessful action) {
  return state.rebuild((AppStateBuilder b) {
    b.user.photo = action.url;
  });
}

AppState _getReviewSuccessful(AppState state, GetReviewsSuccessful action) {
  return state.rebuild((AppStateBuilder b) {
    b.reviews
      ..clear()
      ..addAll(action.reviews);
  });
}
