

import 'user_provider.dart';
import '../model/user.dart';

class UserLocalProvider implements UserProvider {
  final List<User> _users = [
    for (int i in List.generate(15, (i) => i))
      User(fullName: "Bad Boys", phone: "What r u", passwordHash: "imageUrl", booked: [], balance: 0.0)
  ];

  @override
  addUser(User user) async {
    return _users.add(user);
  }

  @override
  editUser(String id, User user) async {
    int index = -1;
    for (int i = 0; i < _users.length; i++) {
      if (_users[i].id == id) {
        index = i;
        break;
      }
    }

    if (index == -1) {
      throw Exception("User not found");
    }

    _users[index] = User(fullName: user.fullName,
        phone: user.phone,
        passwordHash: user.passwordHash,
        booked: user.booked,
        balance: user.balance);
  }

  @override
  Future<User> getUser(String id) async {
    for (int i = 0; i < _users.length; i++) {
      if (_users[i].id == id) {
        return _users[i];
      }
    }

    throw Exception('User not found');
  }

  @override
  Future<List<User>> getAllUsers() async {
    return _users;
  }
}
