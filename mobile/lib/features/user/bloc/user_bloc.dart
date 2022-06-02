import 'package:flutter_bloc/flutter_bloc.dart';

import '../repository/user_repository.dart';
import 'user_event.dart';
import 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository;
  // final String query;

  UserBloc(this.userRepository) : super(UsersLoading()) {
    on<LoadUsers>(_onLoadUsers);
    on<UpdateUser>(_onUpdateUser);
  }

  void _onLoadUsers(LoadUsers event, Emitter emit) async {
    emit(UsersLoading());
    await Future.delayed(const Duration(seconds: 3));
    final users = await userRepository.getAllUsers();
    if (users.hasError) {
      emit(UsersLoadingFailed(users.error!));
    } else {
      emit(UsersLoaded(users.val!));
    }
  }

  void _onUpdateUser(UpdateUser event, Emitter emit) async {
    await userRepository.editUser(event.user.id, event.user);
    emit(UpdateSuccessful());
  }
}
