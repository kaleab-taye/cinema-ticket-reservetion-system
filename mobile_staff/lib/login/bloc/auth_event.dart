
import 'package:sec_2/login/models/login.dart';

abstract class AuthEvent {}

class LoginAuth extends AuthEvent {
  final Login login;
  LoginAuth(this.login);
}
