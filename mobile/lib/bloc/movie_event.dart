part of 'movie_bloc.dart';

abstract class MovieEvent extends Equatable {
  const MovieEvent();

  @override
  List<Object> get props => [];
}

class LoadMovieCounter extends MovieEvent {}

class AddMovie extends MovieEvent {
  final Movie movie;

  const AddMovie(this.movie);

  @override
  List<Object> get props => [movie];
}

class RemoveMovie extends MovieEvent {
  final Movie movie;

  const RemoveMovie(this.movie);

  @override
  List<Object> get props => [movie];
}
