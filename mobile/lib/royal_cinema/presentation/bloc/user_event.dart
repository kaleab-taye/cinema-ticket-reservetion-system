
import 'package:equatable/equatable.dart';

import '../../domain/entities/user.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class LoadUserCounter extends UserEvent {}

class AddUser extends UserEvent {
  final User user;

  const AddUser(this.user);

  @override
  List<Object> get props => [user];
}

class RemoveUser extends UserEvent {
  final User user;

  const RemoveUser(this.user);

  @override
  List<Object> get props => [user];
}
