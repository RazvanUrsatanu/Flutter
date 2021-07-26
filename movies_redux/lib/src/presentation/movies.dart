import 'package:flutter/material.dart';
import 'package:movies_redux/src/container/movie_container.dart';
import 'package:movies_redux/src/models/index.dart';

class Movies extends StatelessWidget {
  const Movies({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
        );
      },
    );
  }
}
