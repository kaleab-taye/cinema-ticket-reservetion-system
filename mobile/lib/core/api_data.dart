import 'token_data.dart';

// Local base url - http://127.0.0.1:5000

class ApiData{
  static String baseUrl = 'http://127.0.0.1:5000/${TokenData.token}';
  static String imageBaseUrl = 'http://127.0.0.1:5000';
}