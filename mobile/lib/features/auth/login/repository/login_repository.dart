
import '../data_provider/data_provider.dart';
import '../models/login.dart';

class LoginRepository {
  LoginDataProvider dataProvider;

  LoginRepository(this.dataProvider);

  Future loginUser(Login login) async {
    try{
      await dataProvider.loginUser(login);
    }
    catch(e){
      throw e;
    }
  }
}