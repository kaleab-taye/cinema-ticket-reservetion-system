abstract class AuthEvent {}

class Login extends AuthEvent {
  final String phone;
  final String password;

  Login({required this.phone, required this.password});
}
