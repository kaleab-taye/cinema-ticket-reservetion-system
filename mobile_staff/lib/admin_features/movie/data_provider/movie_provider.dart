
import 'package:sec_2/admin_features/movie/index.dart';

abstract class MovieProvider {
  // Future<void> addMovie(Movie movie);
  // Future<void> editMovie(int id, Movie movie);
  // Future<Movie> getMovie(int id);
  Future<List<Movie>> getAllMovies();
}