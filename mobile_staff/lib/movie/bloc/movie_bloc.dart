import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sec_2/movie/bloc/movie_event.dart';
import 'package:sec_2/movie/bloc/movie_state.dart';
import 'package:sec_2/movie/repository/movie_repository.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final MovieRepository movieRepository;

  MovieBloc(this.movieRepository) : super(MoviesLoading()) {
    on<LoadMovies>(_onLoadMovies);
    on<UpdateMovie>(_onUpdateMovie);
  }

  void _onLoadMovies(LoadMovies event, Emitter emit) async {
    emit(MoviesLoading());
    // await Future.delayed(const Duration(seconds: 3));
    final movies = await movieRepository.getAllMovies();
    if (movies.hasError) {
      emit(MoviesLoadingFailed(movies.error!));
    } else {
      emit(MoviesLoaded(movies.val!));
    }
  }

  void _onUpdateMovie(UpdateMovie event, Emitter emit) async {
    // await movieRepository.editMovie(event.movie.id, event.movie);
    emit(UpdateSuccessful());
  }
}
