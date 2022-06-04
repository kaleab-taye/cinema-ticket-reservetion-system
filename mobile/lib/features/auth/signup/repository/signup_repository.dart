
import '../data_provider/data_provider.dart';
import '../models/signup.dart';

class SignUpRepository {
  SignUpDataProvider dataProvider;

  SignUpRepository(this.dataProvider);

  Future signUpUser(SignUp signUp) async {
    try {
      await dataProvider.signUpUser(signUp);
    } catch (e){
      throw e;
    }
  }

  Future signUpVerify(SignUp signUp) async {
    try{
      await dataProvider.signUpVerify(signUp);
    } catch(e){
      throw e;
    }
  }

}