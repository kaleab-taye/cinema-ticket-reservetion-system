
import 'package:royal_cinema/features/mobile_staff/movie/index.dart';

abstract class MovieEvent {}

class LoadMovies extends MovieEvent {}

class UpdateMovie extends MovieEvent {
  final Movie movie;
  UpdateMovie(this.movie);
}
