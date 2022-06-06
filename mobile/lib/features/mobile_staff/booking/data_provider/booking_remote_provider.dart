import 'dart:convert';

import 'package:royal_cinema/features/mobile_staff/booking/data_provider/booking_provider.dart';
import 'package:royal_cinema/features/mobile_staff/booking/model/booking.dart';
import 'package:royal_cinema/features/mobile_staff/booking/model/booking_response.dart';

import 'package:http/http.dart' as http;
import 'package:royal_cinema/core/staff_core/api_data.dart';
import 'package:royal_cinema/core/staff_core/user_data.dart';

class BookingRemoteProvider implements BookingProvider {
  final _baseUrl = '${apiData.baseUrl}/${UserData.token}'; //new
  // final authTok = apiData.userToken;

  // var test = apiData.getToken();

  late http.Client httpClient;

  @override
  Future<List<BookingResponse>> getAllBookings() async {
    final headerr = await apiData.getHeader();

    final response =
        await http.get(Uri.parse('${_baseUrl}/bookings'), headers: headerr);

    print(response.statusCode);

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
    req.headers.addAll(await apiData.getHeader());

    var res = await req.send();
    final resBody = await res.stream.bytesToString();


    if (res.statusCode >= 200 && res.statusCode < 300) {
      final schedule = jsonDecode(resBody);
      return resBody.toLowerCase() == 'true' ? true : false;
    } else {
      throw Exception('Failed to delete booking');
    }
  }
}
