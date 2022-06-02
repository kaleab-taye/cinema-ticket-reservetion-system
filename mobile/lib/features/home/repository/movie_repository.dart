
import 'package:royal_cinema/core/utils/either.dart';

import '../data_provider/movie_provider.dart';
import '../model/movie.dart';

class MovieRepository {
  MovieProvider movieProvider;
  MovieRepository(this.movieProvider);

  Future<List<Movie>> getMoviesWithTitle(String title) async {
    final movies = await movieProvider.getAllMovies();
    return movies.where((movie) => movie.title == title).toList();
  }

  Future<Either<List<Movie>>> getAllMovies() async {
    try {
      final movies = await movieProvider.getAllMovies();
      return Either(val: movies);
    } catch (err) {
      print(err);
      return Either(error: "Couldn't load movies");
    }
  }

  Future<Either<Movie>> getMovie(String id) async {
    try {
      final movie = await movieProvider.getMovie(id);
      return Either(val: movie);
    } catch (err) {
      return Either(error: "Movie not found");
    }
  }

  addMovie(Movie movie) async {
    // check for profanity
    // movie.description.contains("sidib");
    final newMovie = Movie(
        id: movie.id,
        title: movie.title,
        description: movie.description,
        imageUrl: movie.imageUrl,
        casts: movie.casts,
        genera: movie.genera);

    await movieProvider.addMovie(newMovie);
  }

  Future<Either<String>> editMovie(String id, Movie movie) async {
    try {
      final newMovie = Movie(
          id: movie.id,
          title: movie.title,
          description: movie.description,
          imageUrl: movie.imageUrl,
          casts: movie.casts,
          genera: movie.genera);

      await movieProvider.editMovie(id, newMovie);
      return Either(val: "");
    } catch (err) {
      return Either(error: "Movie not found");
    }
  }
}
