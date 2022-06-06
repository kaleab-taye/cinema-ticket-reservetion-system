import '../model/user.dart';

abstract class UserEvent {}

class LoadUsers extends UserEvent {}

class LoadUser extends UserEvent {
  final User user;
  LoadUser(this.user);
}

class UpdateBalance extends UserEvent {
  final price;
  UpdateBalance(this.price);
}

class LoadCurrentUser extends UserEvent{}

class EditUser extends UserEvent {
  final fullName;
  final phone;
  final passwordHash;
  EditUser(this.fullName, this.phone, this.passwordHash);
}

class UpdateUser extends UserEvent {
  final User user;
  UpdateUser(this.user);
}
