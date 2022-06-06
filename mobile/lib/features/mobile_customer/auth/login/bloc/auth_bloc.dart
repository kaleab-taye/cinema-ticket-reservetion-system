import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:royal_cinema/features/mobile_customer/auth/login/login.dart';
import 'bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {

  final LoginRepository loginRepository;

  AuthBloc(this.loginRepository) : super(Idle()) {
    on<LoginAuth>(_onLoginAuth);
  }

  void _onLoginAuth(LoginAuth event, Emitter emit) async {

    try {
      await loginRepository.loginUser(event.login);
      emit(LoginSuccessful());
    }
    catch(e){
      emit(LoginFailed());
    }
  }
}

