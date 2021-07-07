import 'package:movies_redux/src/models/movie.dart';

class GetMovies {
  const GetMovies();

  @override
  String toString() {
    return 'GetMovies{}';
  }
}

class GetMoviesSuccessful {
  final List<Movie> movies;

  GetMoviesSuccessful(this.movies);

  @override
  String toString() {
    return 'GetMoviesSuccessful{movies: $movies}';
  }
}

class GetMoviesError {
  final dynamic error;

  GetMoviesError(this.error);

  @override
  String toString() {
    return 'GetMoviesError{error: $error}';
  }
}
