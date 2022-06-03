import 'package:meta/meta.dart';

import '../data_provider/data_provider.dart';
import '../models/signup.dart';

class SignUpRepository {
  SignUpDataProvider dataProvider;

  SignUpRepository(this.dataProvider);

  Future signUpUser(SignUp signUp) async {
    await dataProvider.signUpUser(signUp);
  }
}