import 'package:sec_2/admin_features/movie/index.dart';

import '../../utils/either.dart';

class MovieRepository {
  MovieProvider movieProvider;
  MovieRepository(this.movieProvider);

  // Future<List<Movie>> getMoviesWithPriority(int priority) async {
  //   final movies = await movieProvider.getAllMovies();
  //   return movies.where((movie) => movie.priority == priority).toList();
  // }

  Future<Either<List<Movie>>> getAllMovies() async {
    try {
      final movies = await movieProvider.getAllMovies();
      return Either(val: movies);
    } catch (err) {
      return Either(error: "Couldn't load movies");
    }
  }

  // Future<Either<Movie>> getMovie(int id) async {
  //   try {
  //     final movie = await movieProvider.getMovie(id);
  //     return Either(val: movie);
  //   } catch (err) {
  //     return Either(error: "Movie not found");
  //   }
  // }

  // addMovie(Movie movie) async {
  //   // check for profanity
  //   // movie.description.contains("sidib");
  //   final newMovie = Movie(
  //     id: movie.id,
  //     priority: movie.priority,
  //     description: movie.description.trim(),
  //   );

  //   await movieProvider.addMovie(newMovie);
  // }

  // Future<Either<String>> editMovie(String id, Movie movie) async {
  //   try {
  //     final newMovie = Movie(
  //       id: movie.id,
  //       priority: movie.priority,
  //       description: movie.description.trim(),
  //     );

  //     await movieProvider.editMovie(id, newMovie);
  //     return Either(val: "");
  //   } catch (err) {
  //     return Either(error: "Movie not found");
  //   }
  // }
}
