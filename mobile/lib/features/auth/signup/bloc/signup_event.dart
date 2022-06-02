abstract class SignUpEvent {}

class SignUp extends SignUpEvent {
  final String fullName;
  final String phone;
  final String password;

  SignUp({required this.fullName, required this.phone, required this.password});
}
