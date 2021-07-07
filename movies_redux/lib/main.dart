import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:movies_redux/src/actions/get_movies.dart';
import 'package:movies_redux/src/data/movie_api.dart';
import 'package:movies_redux/src/middleware/app_middleware.dart';
import 'package:movies_redux/src/models/app_state.dart';
import 'package:movies_redux/src/reducer/reducer.dart';
import 'package:redux/redux.dart';

void main() {
  final Client client = Client();
  final MovieApi movieApi = MovieApi(client: client);
  final AppMiddleware middleware = AppMiddleware(movieApi: movieApi);
  final AppState state = AppState.initialState();
  final Store<AppState> store = Store<AppState>(
    reducer,
    initialState: state,
    middleware: middleware.middleware,
  );
  store.dispatch(GetMovies());
  runApp(MyApp(store: store));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.store}) : super(key: key);
  final Store<AppState> store;

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
        store: store,
        child: const MaterialApp(
          home: MyHomePage(),
        ));
  }
}
