import 'package:equatable/equatable.dart';

import '../models/movie.dart';

abstract class MovieEvent extends Equatable {
  const MovieEvent();
}

class MovieLoad extends MovieEvent {
  const MovieLoad();

  @override
  List<Object> get props => [];
}

class MovieCreate extends MovieEvent {
  final Movie movie;

  const MovieCreate(this.movie);

  @override
  List<Object> get props => [movie];

  @override
  String toString() => 'Movie Created {movie: $movie}';
}

class MovieUpdate extends MovieEvent {
  final Movie movie;

  const MovieUpdate(this.movie);

  @override
  List<Object> get props => [movie];

  @override
  String toString() => 'Movie Updated {movie: $movie}';
}

class MovieDelete extends MovieEvent {
  final Movie movie;

  const MovieDelete(this.movie);

  @override
  List<Object> get props => [movie];

  @override
  toString() => 'Movie Deleted {movie: $movie}';
}
