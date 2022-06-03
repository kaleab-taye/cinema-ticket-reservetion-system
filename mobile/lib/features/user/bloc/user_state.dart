import '../model/user.dart';

abstract class UserState {}

class UsersLoading extends UserState {}

class UsersLoaded extends UserState {
  // List<User> users;
  User users;
  UsersLoaded(this.users);
}

class UsersLoadingFailed extends UserState {
  final String msg;
  UsersLoadingFailed(this.msg);
}

class UpdateSuccessful extends UserState {}
