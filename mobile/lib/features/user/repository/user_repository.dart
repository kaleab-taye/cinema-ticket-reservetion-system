
import 'package:royal_cinema/core/local_data_provider.dart';

import '../../../core/utils/either.dart';
import '../data_provider/user_provider.dart';
import '../model/user.dart';

class UserRepository {
  UserProvider userProvider;
  UserRepository(this.userProvider);

  Future<List<User>> getUsersWithTitle(String fullName) async {
    final users = await userProvider.getAllUsers();
    return users.where((user) => user.fullName == fullName).toList();
  }

  Future<User> getAllUsers() async {

    LocalDbProvider localDbProvider = LocalDbProvider();
    try {
      final user = await localDbProvider.getUser();
      return user;
    } catch (e) {
      throw e;
    }
  }

  Future<Either<User>> getUser(String id) async {
    try {
      final user = await userProvider.getUser(id);
      return Either(val: user);
    } catch (err) {
      return Either(error: "User not found");
    }
  }

  updateBalance(int price) async {
    try{
      await userProvider.updateBalance(price);
    }
    catch(e){
      throw e;
    }
  }

  // addUser(User user) async {
  //   // check for profanity
  //   // user.description.contains("sidib");
  //   final newUser = User(
  //       id: user.id,
  //       fullName: user.fullName,
  //       phone: user.phone,
  //       passwordHash: user.passwordHash,
  //       balance: user.balance);
  //
  //   await userProvider.addUser(newUser);
  // }

  // Future<Either<String>> editUser(String id, User user) async {
  //   try {
  //     final newUser = User(
  //         id: user.id,
  //         fullName: user.fullName,
  //         phone: user.phone,
  //         passwordHash: user.passwordHash,
  //         balance: user.balance);
  //
  //     await userProvider.editUser(id, newUser);
  //     return Either(val: "");
  //   } catch (err) {
  //     return Either(error: "User not found");
  //   }
  // }
}
