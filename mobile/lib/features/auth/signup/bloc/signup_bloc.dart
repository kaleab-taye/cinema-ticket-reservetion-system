import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:royal_cinema/features/auth/signup/signup.dart';
import 'bloc.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {

  final SignUpRepository signUpRepository;

  SignUpBloc(this.signUpRepository) : super(Idle()) {
    on<SignUpAuth>(_onSignUpAuth);
  }

  void _onSignUpAuth(SignUpAuth event, Emitter emit) async {
    await signUpRepository.signUpUser(event.signUp);
    emit(SignUpSuccessful());
  }
}
