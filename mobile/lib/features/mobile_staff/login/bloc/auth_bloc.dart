import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:royal_cinema/features/mobile_staff/login/bloc/auth_event.dart';
import 'package:royal_cinema/features/mobile_staff/login/bloc/auth_state.dart';
import 'package:royal_cinema/features/mobile_staff/login/repository/login_repository.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginRepository loginRepository;

  AuthBloc(this.loginRepository) : super(Idle()) {
    on<LoginAuth>(_onLoginAuth);
  }

  void _onLoginAuth(LoginAuth event, Emitter emit) async {
    final loginResult = await loginRepository.getLoggedIn(event.login);

    if (loginResult.hasError) {
      // print("fail");
      print(state);

      emit(LoginFailed(loginResult.error!));
      // event.go('/MovieDetail',extra: state.movies[index])
      print(state);
    } else {
      // print("success");
      print(state);
      emit(LoginSuccessful());
      
      print(state);
    }
  }
}


// class MovieBloc extends Bloc<MovieEvent, MovieState> {
//   final MovieRepository movieRepository;

//   MovieBloc(this.movieRepository) : super(MoviesLoading()) {
//     on<LoadMovies>(_onLoadMovies);
//     on<UpdateMovie>(_onUpdateMovie);
//   }

//   void _onLoadMovies(LoadMovies event, Emitter emit) async {
//     emit(MoviesLoading());
//     // await Future.delayed(const Duration(seconds: 3));
//     final movies = await movieRepository.getAllMovies();
//     if (movies.hasError) {
//       emit(MoviesLoadingFailed(movies.error!));
//     } else {
//       emit(MoviesLoaded(movies.val!));
//     }
//   }

//   void _onUpdateMovie(UpdateMovie event, Emitter emit) async {
//     // await movieRepository.editMovie(event.movie.id, event.movie);
//     emit(UpdateSuccessful());
//   }
// }

