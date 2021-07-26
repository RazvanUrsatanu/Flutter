import 'package:movies_redux/src/actions/index.dart';
import 'package:movies_redux/src/data/movie_api.dart';
import 'package:movies_redux/src/models/index.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:rxdart/rxdart.dart';

class AppEpic {
  const AppEpic({required MovieApi movieApi}) : _movieApi = movieApi;
  final MovieApi _movieApi;

  Epic<AppState> get epics {
    return combineEpics(<Epic<AppState>>[
      TypedEpic<AppState, GetMoviesStart>(_getMovies),
    ]);
  }

  Stream<AppAction> _getMovies(Stream<GetMoviesStart> actions, EpicStore<AppState> store) {
    return actions
        .asyncMap((GetMoviesStart event) => _movieApi.getMovie(store.state.page))
        .map((List<Movie> movies) => GetMovies.successful(movies))
        .onErrorReturnWith((Object error, StackTrace st) => GetMovies.error(error, st));
  }
}
