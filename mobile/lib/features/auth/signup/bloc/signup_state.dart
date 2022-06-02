abstract class SignUpState {}

class Idle extends SignUpState {}

class SigningUp extends SignUpState {}

class SignUpSuccessful extends SignUpState {}

class SignUpFailed extends SignUpState {}
