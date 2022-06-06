import 'package:royal_cinema/features/mobile_staff/index/data_provider/local_user_data_provider.dart';
import 'package:royal_cinema/features/mobile_staff/index/repository/index_repository.dart';
import 'package:royal_cinema/features/mobile_staff/user/models/staff.dart';

class apiData {
  // static const baseUrl = 'http://127.0.0.1:5000'; //new
  // Emulator base url - 10.0.2.2
  static const baseUrl = 'http://10.5.197.136:5000';

  //For emulator
  // static const baseUrl = 'http://10.0.2.2.136:5000';

  static IndexRepository indexRepository = IndexRepository(IndexDataProvider());

  static Future<String> getToken() async {
    final Staff loginCheck = await indexRepository.getLoggedInStaff();

    final String loginToken = await loginCheck.loginToken!;

    return loginToken;
  }

  static Future<Map<String, String>> getHeader() async {
    final Staff loginCheck = await indexRepository.getLoggedInStaff();

    final String loginToken = await loginCheck.loginToken!;

    final headersList = {
      "Accept": "*/*",
      "User-Agent": "Thunder Client (https://www.thunderclient.com)",
      "Authorization": "bearer "+loginToken,
      'Content-Type': 'application/json'
    };
    // print(headersList);
    return headersList;
  }

  // this.getToken()
  static const userToken =
      // this.getToken();

      "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0eXBlIjoic3RhZmYiLCJpZCI6IjYyOThiOTZmZTk1OThmYWNmMGI2OTQwYyIsImlhdCI6MTY1NDIwMTg0NX0.BkxEosQ8y2jVSZkRDhfohOe9dB0K7wVOnv-VwHSu69k";
}
