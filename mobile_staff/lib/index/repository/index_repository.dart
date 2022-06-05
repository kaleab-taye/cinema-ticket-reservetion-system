import 'package:sec_2/index/data_provider/local_user_data_provider.dart';
import 'package:sec_2/login/data_provider/login_data_provider.dart';
import 'package:sec_2/login/models/login_response.dart';
import 'package:sec_2/movie/index.dart';
import 'package:sec_2/user/models/staff.dart';

import '../../utils/either.dart';

class IndexRepository {
  IndexDataProvider indexProvider;
  IndexRepository(this.indexProvider);

  // Future<Either<bool>> isUserLoggedIn() async {
  //   try {
  //     final bool user = await indexProvider.isUserLoggedIn();
  //     return Either(val: user);
  //   } catch (err) {
  //     return Either(error: "Checking Logged In Failed");
  //   }
  // }

  Future<Either<bool>> isStaffLoggedIn() async {
    try {
      final bool user = await indexProvider.isStaffLoggedIn();
      return Either(val: user);
    } catch (err) {
      return Either(error: "Checking Logged In Failed");
    }
  }

  Future<Either<int>> loginStaff(staff) async {


    try {
      final int user = await indexProvider.loginStaff(staff);
      return Either(val: user);
    } catch (err) {
      return Either(error: "Checking Logged In Failed");
    }
  }

  Future<Either<int>> logoutStaff() async {


    try {
      final int user = await indexProvider.logoutStaff();
      return Either(val: user);
    } catch (err) {
      return Either(error: "Checking Logged In Failed");
    }
  }

}
