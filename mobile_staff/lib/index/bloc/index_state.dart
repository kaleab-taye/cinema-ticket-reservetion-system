import 'package:sec_2/login/models/login_response.dart';

abstract class IndexState {}

class Checking extends IndexState {}

class LoggedIn extends IndexState {}

class NotLoggedIn extends IndexState {
  // LoginResponse loginResp;

  // LoginSuccessful(this.loginResp);
}
class CheckFailed extends IndexState {
  final String message;
  CheckFailed(this.message);
}

// class LoginFailed extends AuthState {
//   final String msg;
//   LoginFailed(this.msg);
// }
