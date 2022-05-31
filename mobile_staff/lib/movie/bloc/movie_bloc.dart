import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_network/movie/bloc/bloc.dart';
import 'package:flutter_network/movie/movie.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final MovieRepository movieRepository;

  MovieBloc({@required this.movieRepository})
      : assert(movieRepository != null),
        super(MovieLoading());

  @override
  Stream<MovieState> mapEventToState(MovieEvent event) async* {
    if (event is MovieLoad) {
      yield MovieLoading();
      try {
        print("final movies a/bout to set");
        final movies = await movieRepository.getMovies();
        print("final movies set");
        yield MoviesLoadSuccess(movies);
      } catch (_) {
        print(1);
        print(_);
        yield MovieOperationFailure();
      }
    }

    if (event is MovieCreate) {
      try {
        await movieRepository.createMovie(event.movie);
        final movies = await movieRepository.getMovies();
        yield MoviesLoadSuccess(movies);
      } catch (_) {
        print(2);
        yield MovieOperationFailure();
      }
    }

    if (event is MovieUpdate) {
      try {
        await movieRepository.updateMovie(event.movie);
        final movies = await movieRepository.getMovies();
        yield MoviesLoadSuccess(movies);
      } catch (_) {
        print(3);
        yield MovieOperationFailure();
      }
    }

    if (event is MovieDelete) {
      try {
        await movieRepository.deleteMovie(event.movie.id);
        final movies = await movieRepository.getMovies();
        yield MoviesLoadSuccess(movies);
      } catch (_) {
        print(4);
        yield MovieOperationFailure();
      }
    }
  }
}
