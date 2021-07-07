import 'package:movies_redux/src/actions/get_movies.dart';
import 'package:movies_redux/src/data/movie_api.dart';
import 'package:movies_redux/src/models/app_state.dart';
import 'package:movies_redux/src/models/movie.dart';
import 'package:redux/redux.dart';

class AppMiddleware {
  const AppMiddleware({required MovieApi movieApi}) : _movieApi = movieApi;
  final MovieApi _movieApi;

  List<Middleware<AppState>> get middleware {
    return <Middleware<AppState>>[
      TypedMiddleware<AppState, GetMovies>(_getMovies),
    ];
  }

  Future<void> _getMovies(Store<AppState> store, GetMovies action, NextDispatcher next) async {
    next(action);
    try {
      final List<Movie> movies = await _movieApi.getMovies();
      store.dispatch(GetMoviesSuccessful(movies));
    } catch (err) {
      store.dispatch(GetMoviesError(err));
    }
  }
}
