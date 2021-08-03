import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:http/http.dart';
import 'package:movies_redux/src/actions/index.dart';
import 'package:movies_redux/src/data/auth_api.dart';
import 'package:movies_redux/src/data/movie_api.dart';
import 'package:movies_redux/src/epics/app_epic.dart';
import 'package:movies_redux/src/models/index.dart';
import 'package:movies_redux/src/presentation/create_review.dart';
import 'package:movies_redux/src/presentation/list_of_review.dart';
import 'package:movies_redux/src/presentation/login_page.dart';
import 'package:movies_redux/src/presentation/movies.dart';
import 'package:movies_redux/src/presentation/home_page.dart';
import 'package:movies_redux/src/reducer/reducer.dart';
import 'package:redux/redux.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  final Client client = Client();
  final MovieApi movieApi = MovieApi(client: client, firestore: FirebaseFirestore.instance);
  final AuthApi authApi =
      AuthApi(auth: FirebaseAuth.instance, firestore: FirebaseFirestore.instance, storage: FirebaseStorage.instance);
  final AppEpic epic = AppEpic(movieApi: movieApi, authApi: authApi);

  final AppState state = AppState.initialState();
  final Store<AppState> store = Store<AppState>(
    reducer,
    initialState: state,
    middleware: <Middleware<AppState>>[
      EpicMiddleware<AppState>(epic.epics),
    ],
  );
  store..dispatch(const GetMovies())..dispatch(const InitializeApp());
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
          '/login': (BuildContext context) {
            return const LoginPage();
          },
          'create_review': (BuildContext context) {
            return const CreateReviewPage();
          },
          'list_of_review': (BuildContext context) {
            return const ListOfReview();
          },
        },
      ),
    );
  }
}
