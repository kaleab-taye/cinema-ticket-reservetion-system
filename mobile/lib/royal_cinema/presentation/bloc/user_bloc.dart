import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/user.dart';
import 'bloc.dart';



class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial()) {
    on<LoadUserCounter>((event, emit) async {
      await Future<void>.delayed(const Duration(seconds: 1));
      emit(const UserLoaded(users: <User>[]));
    },);

    on<AddUser>((event, emit) {
      if(state is UserLoaded){
        final state = this.state as UserLoaded;
        emit(
          UserLoaded(users: List.from(state.users)..add(event.user),
          ),
          );
      }
    },);

    on<RemoveUser>((event, emit) {
      if(state is UserLoaded){
        final state = this.state as UserLoaded;
        emit(
          UserLoaded(users: List.from(state.users)..remove(event.user),
          ),
        );
      }
    },);
  }
}
