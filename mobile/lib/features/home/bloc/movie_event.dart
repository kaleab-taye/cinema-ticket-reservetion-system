import '../model/movie.dart';

abstract class MovieEvent {}

class LoadMovies extends MovieEvent {}

class UpdateMovie extends MovieEvent {
  final Movie movie;
  UpdateMovie(this.movie);
}
