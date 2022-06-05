import '../model/user.dart';

abstract class UserProvider {
  // Future<void> addUser(User user);
  // Future<void> editUser(String id, User user);
  Future<User?> getUser(String id);
  Future<List<User>> getAllUsers();
  Future<void> updateBalance(int price);
}
