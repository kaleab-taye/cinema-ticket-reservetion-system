
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

  Future<Either<List<User>>> getAllUsers() async {
    try {
      final users = await userProvider.getAllUsers();
      return Either(val: users);
    } catch (err) {
      print(err);
      return Either(error: "Couldn't load users");
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
