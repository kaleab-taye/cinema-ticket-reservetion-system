
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
