import '../model/user.dart';

abstract class UserState {}

class UsersLoading extends UserState {}

class UsersLoaded extends UserState {
  User user;
  UsersLoaded(this.user);
}

class UsersLoadingFailed extends UserState {}

class UserUpdateSuccessful extends UserState {}

class UpdateBalanceSuccessful extends UserState {}

class UpdateBalanceFailed extends UserState {}

class UpdateBalanceLoading extends UserState {}
