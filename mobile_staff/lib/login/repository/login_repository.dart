import 'package:sec_2/login/data_provider/login_data_provider.dart';
import 'package:sec_2/login/models/login_response.dart';
import 'package:sec_2/movie/index.dart';
import 'package:sec_2/user/models/staff.dart';

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
