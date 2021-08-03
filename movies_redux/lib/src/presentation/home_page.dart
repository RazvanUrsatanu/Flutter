import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:image_picker/image_picker.dart';
import 'package:movies_redux/src/actions/index.dart';
import 'package:movies_redux/src/container/loading_container.dart';
import 'package:movies_redux/src/container/movies_container.dart';
import 'package:movies_redux/src/container/user_container.dart';
import 'package:movies_redux/src/models/index.dart';

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
                title: const Text('Movies'),
                leading: GestureDetector(
                  onTap: () async {
                    //StoreProvider.of<AppState>(context).dispatch(const SignOut());
                    final XFile? file = await ImagePicker().pickImage(source: ImageSource.gallery, maxWidth: 500);
                    if (file == null) {
                      return;
                    }

                    StoreProvider.of<AppState>(context).dispatch(UpdateProfileUrl(file.path));
                  },
                  child: UserContainer(
                    builder: (BuildContext context, AppUser? user) {
                      if (user == null) {
                        return const SizedBox.shrink();
                      }
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          child: user.photo == null ? Text(user.username[0].toUpperCase()) : null,
                          backgroundImage: user.photo != null ? NetworkImage(user.photo!) : null,
                        ),
                      );
                    },
                  ),
                ),
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
                      StoreProvider.of<AppState>(context)..dispatch(SelectMovie(index))..dispatch(const GetReviews());
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
