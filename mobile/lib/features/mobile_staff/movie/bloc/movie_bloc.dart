import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:royal_cinema/features/mobile_staff/movie/index.dart';
import 'package:royal_cinema/features/mobile_staff/movie/repository/movie_repository.dart';

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
