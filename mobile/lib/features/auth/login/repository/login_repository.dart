import 'package:meta/meta.dart';

import '../data_provider/data_provider.dart';
import '../models/login.dart';

class LoginRepository {
  LoginDataProvider dataProvider;

  LoginRepository(this.dataProvider);

  Future loginUser(Login login) async {
    await dataProvider.loginUser(login);
  }
}