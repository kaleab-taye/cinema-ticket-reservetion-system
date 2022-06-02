import 'package:meta/meta.dart';

import '../data_provider/data_provider.dart';
import '../models/login.dart';

class LoginRepository {
  LoginDataProvider dataProvider;

  LoginRepository(this.dataProvider);

  Future<Login> loginUser(Login login) async {
    return await dataProvider.loginUser(login);
  }
}