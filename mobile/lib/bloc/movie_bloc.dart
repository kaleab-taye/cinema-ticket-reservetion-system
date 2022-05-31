import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../royal_cinema/domain/entities/movie.dart';

part 'movie_event.dart';
part 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  MovieBloc() : super(MovieInitial()) {
    on<LoadMovieCounter>((event, emit) async {
      await Future<void>.delayed(const Duration(seconds: 1));
      emit(const MovieLoaded(movies: <Movie>[]));
    },);

    on<AddMovie>((event, emit) {
      if(state is MovieLoaded){
        final state = this.state as MovieLoaded;
        emit(
          MovieLoaded(movies: List.from(state.movies)..add(event.movie),
          ),
        );
      }
    },);

    on<RemoveMovie>((event, emit) {
      if(state is MovieLoaded){
        final state = this.state as MovieLoaded;
        emit(
          MovieLoaded(movies: List.from(state.movies)..remove(event.movie),
          ),
        );
      }
    },);
  }
}
