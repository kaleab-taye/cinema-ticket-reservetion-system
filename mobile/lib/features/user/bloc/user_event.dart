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

class UpdateUser extends UserEvent {
  final User user;
  UpdateUser(this.user);
}
