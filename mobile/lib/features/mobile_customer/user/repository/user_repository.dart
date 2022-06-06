
import 'package:royal_cinema/features/mobile_customer/user/data_provider/local_data_provider.dart';

import '../../../../core/customer_core/utils/either.dart';
import '../data_provider/user_provider.dart';
import '../model/user.dart';

class UserRepository {
  UserProvider userProvider;
  UserRepository(this.userProvider);

  Future<User> getAllUsers() async {

    LocalDbProvider localDbProvider = LocalDbProvider();
    try {
      final user = await localDbProvider.getUser();
      return user;
    } catch (e) {
      throw e;
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

  editUser(String fullName, String phone, String passwordHash) async {
    try{
      await userProvider.editUser(fullName, phone, passwordHash);
    }
    catch(e){
      print("Error 2");
      throw e;
    }
  }
}
