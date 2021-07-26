import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:http/http.dart';
import 'package:movies_redux/src/actions/index.dart';
import 'package:movies_redux/src/data/movie_api.dart';
import 'package:movies_redux/src/epics/app_epic.dart';
import 'package:movies_redux/src/models/index.dart';
import 'package:movies_redux/src/presentation/movies.dart';
import 'package:movies_redux/src/presentation/home_page.dart';
import 'package:movies_redux/src/reducer/reducer.dart';
import 'package:redux/redux.dart';
import 'package:redux_epics/redux_epics.dart';

void main() {
  final Client client = Client();
  final MovieApi movieApi = MovieApi(client: client);
  final AppEpic epic = AppEpic(movieApi: movieApi);

  final AppState state = AppState.initialState();
  final Store<AppState> store = Store<AppState>(
    reducer,
    initialState: state,
    middleware: <Middleware<AppState>>[
      EpicMiddleware<AppState>(epic.epics),
    ],
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
      child: MaterialApp(
        home: const HomePage(),
        theme: ThemeData.dark(),
        routes: <String, WidgetBuilder>{
          '/movie_details': (BuildContext context) {
            return const Movies();
          },
        },
      ),
    );
  }
}
