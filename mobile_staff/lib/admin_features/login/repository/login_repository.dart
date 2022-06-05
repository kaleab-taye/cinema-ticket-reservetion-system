

import 'package:sec_2/admin_features/login/data_provider/login_data_provider.dart';
import 'package:sec_2/admin_features/login/models/login_response.dart';

import '../../utils/either.dart';

class LoginRepository {
  LoginDataProvider loginProvider;
  LoginRepository(this.loginProvider);

  Future<Either<LoginResponse>> getLoggedIn(loginData) async {
    try {
      final LoginResponse user = await loginProvider.getLoggedIn(loginData);
      return Either(val: user);
    } catch (err) {
      return Either(error: "Login Data Couldn't Be Found");
    }
  }
}
