import 'dart:convert';

import 'package:royal_cinema/features/mobile_staff/images/image.dart';
import 'package:royal_cinema/core/staff_core/api_data.dart';
import 'package:http/http.dart' as http;

class ImageProvider {
  final _baseUrl = '$apiData.baseUrl'; //new

  late http.Client httpClient;

  Future<ImageFile> getImage(url) async {
    final response = await http.get(Uri.parse('${_baseUrl}/${url}'));
    // final response = await httpClient.get(_baseUrl);
    if (response.statusCode == 200) {
      final image = jsonDecode(response.body) as ImageFile;
      // return movies.map((movie) => Movie.fromJson(movie)).toList();
      return image;
    } else {
      throw Exception('Failed to load movies');
    }
  }
}
