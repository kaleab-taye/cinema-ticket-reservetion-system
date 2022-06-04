import 'package:sec_2/movie/index.dart';

abstract class MovieEvent {}

class LoadMovies extends MovieEvent {}

class UpdateMovie extends MovieEvent {
  final Movie movie;
  UpdateMovie(this.movie);
}
