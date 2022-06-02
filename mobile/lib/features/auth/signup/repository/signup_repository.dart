import 'package:meta/meta.dart';

import '../data_provider/data_provider.dart';
import '../models/signup.dart';

class SignUpRepository {
  final SignUpDataProvider dataProvider;

  SignUpRepository({required this.dataProvider})
      : assert(dataProvider != null);

  Future<SignUp> signUpUser(SignUp signUp) async {
    return await dataProvider.signUpUser(signUp);
  }
}