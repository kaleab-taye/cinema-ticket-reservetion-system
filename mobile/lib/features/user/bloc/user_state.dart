import '../model/user.dart';

abstract class UserState {}

class UsersLoading extends UserState {}

class UsersLoaded extends UserState {}

class UsersLoadingFailed extends UserState {}

class UserUpdateSuccessful extends UserState {}
