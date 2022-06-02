import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:royal_cinema/features/auth/login/login.dart';
import 'bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {

  final LoginRepository loginRepository;

  AuthBloc(this.loginRepository) : super(Idle()) {
    on<LoginAuth>(_onLogin);
  }

  void _onLogin(LoginAuth event, Emitter emit) async {
    await loginRepository.loginUser(event.login);
    emit(LoginSuccessful());
  }
}

