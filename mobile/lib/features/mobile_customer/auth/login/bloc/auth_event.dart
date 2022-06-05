import 'package:royal_cinema/features/mobile_customer/auth/login/models/login.dart';

abstract class AuthEvent {}

class LoginAuth extends AuthEvent {
  final Login login;
  LoginAuth(this.login);
}
