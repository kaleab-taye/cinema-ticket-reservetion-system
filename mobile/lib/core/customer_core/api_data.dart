import 'token_data.dart';

// Local base url - http://127.0.0.1:5000
// AVD base url - 10.0.2.2

class ApiData{
  static String baseUrl = 'http://10.5.197.136:5000/${TokenData.token}';
  static String imageBaseUrl = 'http://10.5.197.136:5000';
}