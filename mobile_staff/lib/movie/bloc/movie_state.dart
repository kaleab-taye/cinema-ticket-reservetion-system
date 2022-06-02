import 'package:equatable/equatable.dart';
import '../models/movie.dart';

class MovieState extends Equatable {
  const MovieState();

  @override
  List<Object> get props => [];
}

class MovieLoading extends MovieState {}

class MoviesLoadSuccess extends MovieState {
  final List<Movie> movies;

  MoviesLoadSuccess([this.movies = const []]);

  @override
  List<Object> get props => [movies];
}

class MovieOperationFailure extends MovieState {}
