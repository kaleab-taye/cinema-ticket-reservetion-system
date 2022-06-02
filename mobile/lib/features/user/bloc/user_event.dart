import '../model/user.dart';

abstract class UserEvent {}

class LoadUsers extends UserEvent {}

class UpdateUser extends UserEvent {
  final User user;
  UpdateUser(this.user);
}
