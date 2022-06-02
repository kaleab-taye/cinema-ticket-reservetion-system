import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc() : super(Idle()) {
    on<SignUp>(_onSignUp);
  }

  void _onSignUp(SignUp event, Emitter emit) async {
    emit(SigningUp());
    await Future.delayed(const Duration(seconds: 3));
    emit(SignUpSuccessful());
  }
}
