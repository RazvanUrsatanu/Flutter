import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:movies_redux/src/actions/index.dart';
import 'package:movies_redux/src/container/loading_container.dart';
import 'package:movies_redux/src/container/movies_container.dart';
import 'package:movies_redux/src/models/index.dart';
import 'package:redux/redux.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LoadingContainer(
      builder: (BuildContext context, bool isLoading) {
        return MoviesContainer(
          builder: (BuildContext context, List<Movie> movies) {
            return Scaffold(
              appBar: AppBar(
                title: Text('Movies'),
                actions: <Widget>[
                  if (isLoading)
                    const Center(
                      child: CircularProgressIndicator(),
                    )
                  else
                    IconButton(
                      onPressed: () {
                        StoreProvider.of<AppState>(context).dispatch(const GetMovies());
                      },
                      icon: const Icon(Icons.add),
                    ),
                ],
              ),
              body: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.7,
                ),
                itemCount: movies.length,
                itemBuilder: (BuildContext context, int index) {
                  final Movie movie = movies[index];
                  return GestureDetector(
                    child: SizedBox(
                      child: GridTile(
                        child: Image.network(movie.image),
                        footer: GridTileBar(
                          backgroundColor: Colors.black,
                          title: Text(movie.title),
                        ),
                      ),
                    ),
                    onTap: () {
                      final Store<AppState> store = StoreProvider.of<AppState>(context);
                      store.dispatch(SelectMovie(index));
                      Navigator.pushNamed(context, '/movie_details');
                    },
                  );
                },
              ),
            );
          },
        );
      },
    );
  }
}
