import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies_redux/src/container/movie_container.dart';
import 'package:movies_redux/src/container/user_container.dart';
import 'package:movies_redux/src/models/index.dart';

class Movies extends StatelessWidget {
  const Movies({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return UserContainer(builder: (BuildContext context, AppUser? user) {
      return MovieContainer(
        builder: (BuildContext context, Movie movie) {
          return Scaffold(
            appBar: AppBar(
              title: Text(movie.title),
            ),
            body: Column(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Image.network(movie.largeImage),
                ),
                Expanded(
                  flex: 1,
                  child: Text(movie.summary),
                ),
              ],
            ),
            floatingActionButton: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  TextButton(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: const <Widget>[
                          Icon(Icons.message_outlined),
                          Text('Review'),
                        ],
                      ),
                      onPressed: () {
                        if (user == null) {
                          Navigator.pushNamed(context, '/login');
                        } else {
                          Navigator.pushNamed(context, 'create_review');
                        }
                      }),
                  TextButton(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: const <Widget>[
                          Icon(Icons.message_outlined),
                          Text('Reviews'),
                        ],
                      ),
                      onPressed: () {
                        if (user == null) {
                          Navigator.pushNamed(context, '/login');
                        } else {
                          Navigator.pushNamed(context, 'list_of_review');
                        }
                      }),
                  // label: const Text('Review'),
                  // icon: const Icon(Icons.message_outlined),
                ],
              ),
            ),
          );
        },
      );
    });
  }
}
