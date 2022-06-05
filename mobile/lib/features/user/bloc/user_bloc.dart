import 'package:flutter_bloc/flutter_bloc.dart';

import '../repository/user_repository.dart';
import 'user_event.dart';
import 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository;
  // final String query;

  UserBloc(this.userRepository) : super(UsersLoading()) {
    on<LoadUsers>(_onLoadUsers);
    // on<LoadCurrentUser>(_onLoadCurrentUsers);
    // on<UpdateUser>(_onUpdateUser);
  }

  void _onLoadUsers(LoadUsers event, Emitter emit) async {
    try{
      final user = await userRepository.getAllUsers();
      emit(UsersLoaded(user));
    } catch(e) {
      emit(UsersLoadingFailed());
    }
  }

  // void _onUpdateUser(UpdateUser event, Emitter emit) async {
  //   await userRepository.editUser(event.user.id, event.user);
  //   emit(UserUpdateSuccessful());
  // }
}
