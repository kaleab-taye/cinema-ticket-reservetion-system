import 'package:flutter_test/flutter_test.dart';
import 'package:royal_cinema/features/user/data_provider/user_local_provider.dart';
import 'package:royal_cinema/features/user/model/user.dart';
import 'package:royal_cinema/features/user/repository/user_repository.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  });

  test('User repo: ', () async {
    UserLocalProvider userProvider = UserLocalProvider();
    UserRepository userRepository = UserRepository(userProvider);
    User user = await userRepository.getAllUsers();
    expect(user.id is String, true);
  });
}
