import 'package:flutter_bloc/flutter_bloc.dart';

import '../repository/user_repository.dart';
import 'user_event.dart';
import 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository;
  // final String query;

  UserBloc(this.userRepository) : super(UsersLoading()) {
    on<LoadUsers>(_onLoadUsers);
    on<UpdateBalance>(_onUpdateBalance);
    on<EditUser>(_onEditUser);
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

  void _onUpdateBalance(UpdateBalance event, Emitter emit) async {
    emit(UpdateBalanceLoading());
    await Future.delayed(const Duration(seconds: 1));
    try{
      await userRepository.updateBalance(event.price);
      emit(UpdateBalanceSuccessful());
    } catch (e){
      emit(UpdateBalanceFailed());
    }
  }

  void _onEditUser(EditUser event, Emitter emit) async {
    emit(EditUserLoading());
    await Future.delayed(const Duration(seconds: 1));
    try{
      await userRepository.editUser(event.fullName, event.phone, event.passwordHash);
      emit(EditUserSuccessful());
    } catch (e){
      print("Error");
      print(e);
      emit(EditUserFailed());
    }
  }

  // void _onUpdateUser(UpdateUser event, Emitter emit) async {
  //   await userRepository.editUser(event.user.id, event.user);
  //   emit(UserUpdateSuccessful());
  // }
}
