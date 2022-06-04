import 'dart:convert';

import 'package:sec_2/booking/data_provider/booking_provider.dart';
import 'package:sec_2/booking/model/booking.dart';
import 'package:sec_2/booking/model/booking_response.dart';

import 'package:http/http.dart' as http;
import 'package:sec_2/core/api_data.dart';

import '../../core/user_data.dart';

class BookingRemoteProvider implements BookingProvider {
  final _baseUrl = '${apiData.baseUrl}/${UserData.token}'; //new
  static const authTok = apiData.userToken;

  late http.Client httpClient;

  final headersList = {
    "Accept": "*/*",
    "User-Agent": "Thunder Client (https://www.thunderclient.com)",
    "Authorization": authTok,
    'Content-Type': 'application/json'
  };

  @override
  Future<List<BookingResponse>> getAllBookings() async {
    final response =
        await http.get(Uri.parse('${_baseUrl}/bookings'), headers: headersList);

    if (response.statusCode == 200) {
      final bookingList = jsonDecode(response.body);

      List<BookingResponse> fetchedList = [];

      for (var key in bookingList.keys) {
        List<Booking> listbooking = [];

        for (var booking in bookingList[key]) {
          listbooking.add(Booking.fromJson(booking));
        }

        fetchedList.add(BookingResponse(date: key, bookings: listbooking));
      }
      return fetchedList;
    } else {
      throw Exception('Failed to load booking');
    }
  }

  @override
  Future<bool> deleteBooking(String id) async {
    print(id);
    // print(schedule.capacity);
    var url = Uri.parse('$_baseUrl/bookings/$id');

    var req = http.Request('DELETE', url);
    req.headers.addAll(headersList);

    var res = await req.send();
    final resBody = await res.stream.bytesToString();

    print(resBody);

    if (res.statusCode >= 200 && res.statusCode < 300) {
      final schedule = jsonDecode(resBody);
      return resBody.toLowerCase() == 'true' ? true : false;
    } else {
      throw Exception('Failed to delete booking');
    }
  }
}
