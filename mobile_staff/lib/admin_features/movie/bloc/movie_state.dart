
import 'package:sec_2/admin_features/movie/index.dart';

abstract class MovieState {}

class MoviesLoading extends MovieState {}

class MoviesLoaded extends MovieState {
  List<Movie> movies;
  MoviesLoaded(this.movies);
}

class MoviesLoadingFailed extends MovieState {
  final String msg;
  MoviesLoadingFailed(this.msg);
}

class UpdateSuccessful extends MovieState {}
