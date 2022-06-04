import 'package:sec_2/login/models/login_response.dart';

abstract class AuthState {}

class Idle extends AuthState {}

class LogingIn extends AuthState {}

class LoginSuccessful extends AuthState {
  // LoginResponse loginResp;

  // LoginSuccessful(this.loginResp);
}

class LoginFailed extends AuthState {
  final String msg;
  LoginFailed(this.msg);
}
