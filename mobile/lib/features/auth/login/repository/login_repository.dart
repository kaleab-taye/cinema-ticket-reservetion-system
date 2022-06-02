import 'package:meta/meta.dart';

import '../data_provider/data_provider.dart';
import '../models/login.dart';

class LoginRepository {
  final LoginDataProvider dataProvider;

  LoginRepository({required this.dataProvider})
      : assert(dataProvider != null);

  Future<Login> loginUser(Login login) async {
    return await dataProvider.loginUser(login);
  }
}