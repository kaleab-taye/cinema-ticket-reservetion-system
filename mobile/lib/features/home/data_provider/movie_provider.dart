import '../model/movie.dart';

abstract class MovieProvider {
  Future<void> addMovie(Movie movie);
  Future<void> editMovie(String id, Movie movie);
  Future<Movie?> getMovie(String id);
  Future<List<Movie>> getAllMovies();
}
