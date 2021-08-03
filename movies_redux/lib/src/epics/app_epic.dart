import 'package:movies_redux/src/actions/index.dart';
import 'package:movies_redux/src/data/auth_api.dart';
import 'package:movies_redux/src/data/movie_api.dart';
import 'package:movies_redux/src/models/index.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:rxdart/rxdart.dart';

class AppEpic {
  const AppEpic({required MovieApi movieApi, required AuthApi authApi})
      : _movieApi = movieApi,
        _authApi = authApi;
  final MovieApi _movieApi;
  final AuthApi _authApi;

  Epic<AppState> get epics {
    return combineEpics(<Epic<AppState>>[
      TypedEpic<AppState, GetMoviesStart>(_getMovies),
      TypedEpic<AppState, RegisterStart>(_register),
      TypedEpic<AppState, InitializeAppStart>(_initializeApp),
      TypedEpic<AppState, SignOutStart>(_signOut),
      TypedEpic<AppState, UpdateProfileUrlStart>(_updateProfileUrl),
      TypedEpic<AppState, CreateReviewStart>(_createReviewStart),
      TypedEpic<AppState, GetReviewsStart>(_getReviewsStart),
    ]);
  }

  Stream<AppAction> _getMovies(Stream<GetMoviesStart> actions, EpicStore<AppState> store) {
    return actions
        .asyncMap((GetMoviesStart event) => _movieApi.getMovie(store.state.page))
        .map((List<Movie> movies) => GetMovies.successful(movies))
        .onErrorReturnWith((Object error, StackTrace st) => GetMovies.error(error, st));
  }

  Stream<AppAction> _register(Stream<RegisterStart> actions, EpicStore<AppState> store) {
    return actions.flatMap((RegisterStart action) => Stream<void>.value(null)
        .asyncMap((_) => _authApi.register(action.email, action.password))
        .map((AppUser? user) => Register.successful(user!))
        .onErrorReturnWith((Object error, StackTrace stackTrace) => Register.error(error, stackTrace))
        .doOnData(action.result));
  }

  Stream<AppAction> _initializeApp(Stream<InitializeAppStart> actions, EpicStore<AppState> store) {
    return actions
        .asyncMap((InitializeAppStart event) => _authApi.getCurrentUser())
        .map((AppUser? user) => InitializeApp.successful(user))
        .onErrorReturnWith((Object error, StackTrace st) => InitializeApp.error(error, st));
  }

  Stream<AppAction> _signOut(Stream<SignOutStart> actions, EpicStore<AppState> store) {
    return actions
        .asyncMap((SignOutStart event) => _authApi.signOut())
        .map((_) => const SignOut.successful())
        .onErrorReturnWith((Object error, StackTrace st) => SignOut.error(error, st));
  }

  Stream<AppAction> _updateProfileUrl(Stream<UpdateProfileUrlStart> actions, EpicStore<AppState> store) {
    return actions
        .asyncMap((UpdateProfileUrlStart event) => _authApi.updateProfileUrl(store.state.user!.userId, event.path))
        .map((String url) => UpdateProfileUrl.successful(url))
        .onErrorReturnWith((Object error, StackTrace st) => UpdateProfileUrl.error(error, st));
  }

  Stream<AppAction> _createReviewStart(Stream<CreateReviewStart> actions, EpicStore<AppState> store) {
    return actions
        .asyncMap((CreateReviewStart event) => _movieApi.createReview(event.comment, store.state.user!.userId,
            store.state.movies.toList()[store.state.selectedMovie!].toBuilder().id!))
        .map((_) => const CreateReview.successful())
        .onErrorReturnWith((Object error, StackTrace st) => CreateReview.error(error, st));
  }

  Stream<AppAction> _getReviewsStart(Stream<GetReviewsStart> actions, EpicStore<AppState> store) {
    return actions
        .asyncMap((GetReviewsStart event) =>
            _movieApi.getReviews(store.state.movies.toList()[store.state.selectedMovie!].toBuilder().id!))
        .map((List<Review> review) => GetReviews.successful(review))
        .onErrorReturnWith((Object error, StackTrace st) => GetReviews.error(error, st));
  }
}
