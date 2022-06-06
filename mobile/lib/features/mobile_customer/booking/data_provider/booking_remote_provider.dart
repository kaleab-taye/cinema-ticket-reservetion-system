
import 'dart:convert';

import 'package:royal_cinema/core/customer_core/api_data.dart';
import 'package:royal_cinema/features/mobile_customer/user/data_provider/local_data_provider.dart';
import 'package:royal_cinema/core/customer_core/token_data.dart';
import 'package:http/http.dart' as http;
import 'package:royal_cinema/features/mobile_customer/user/model/user.dart';

import '../model/booking.dart';
import '../model/booking_response.dart';
import 'booking_provider.dart';

class BookingRemoteProvider implements BookingProvider {

  LocalDbProvider localDbProvider = LocalDbProvider();


  @override
  addBooking(BookingMovie booking) async {

    User userOut = await localDbProvider.getUser();

    var headersList = {
      'Accept': '*/*',
      "Authorization": "Bearer ${userOut.loginToken}",
      'Content-Type': 'application/json'
    };
    var url = Uri.parse('${ApiData.baseUrl}/bookings');

    var body = {
      "userId": booking.userId,
      "scheduleId": booking.scheduleId,
      "schedule": booking.schedule,
      "user": booking.user
    };
    var req = http.Request('POST', url);
    req.headers.addAll(headersList);
    req.body = json.encode(body);

    var res = await req.send();
    final resBody = await res.stream.bytesToString();

    if (res.statusCode >= 200 && res.statusCode < 300) {
      print(resBody);
    }
    else {
      throw Exception('Failed to create bookings.');
    }
  }

  @override
  deleteBooking(String bookId) async{

    User userOut = await localDbProvider.getUser();

    var headersList = {
      'Accept': '*/*',
      'Authorization': 'Bearer ${userOut.loginToken}',
    };
    var url = Uri.parse('${ApiData.baseUrl}/bookings/$bookId');

    var req = http.Request('DELETE', url);
    req.headers.addAll(headersList);

    var res = await req.send();
    final resBody = await res.stream.bytesToString();

    if (res.statusCode >= 200 && res.statusCode < 300) {
      print(resBody);
    }
    else {
      print(res.reasonPhrase);
      throw Exception();
    }
  }

  @override
  book(String userId, String scheduleId) async {

    User userOut = await localDbProvider.getUser();

    var headersList = {
      'Accept': '*/*',
      'Authorization': 'Bearer ${userOut.loginToken}',
      'Content-Type': 'application/json'
    };
    var url = Uri.parse('${ApiData.baseUrl}/bookings');

    var body = {
      "userId":userId,
      "scheduleId":scheduleId
    };
    var req = http.Request('POST', url);
    req.headers.addAll(headersList);
    req.body = json.encode(body);

    var res = await req.send();
    final resBody = await res.stream.bytesToString();

    if (res.statusCode >= 200 && res.statusCode < 300) {
      print(resBody);
    }
    else {
      print(res.reasonPhrase);
      throw Exception();
    }
  }

  @override
  editBooking(String id, BookingMovie booking) async {
    User userOut = await localDbProvider.getUser();

    var headersList = {
      'Accept': '*/*',
      "Authorization": "Bearer ${userOut.loginToken}",
      'Content-Type': 'application/json'
    };
    var url = Uri.parse('${ApiData.baseUrl}/bookings/${booking.id}');

    var body = {
      "userId": booking.userId,
      "scheduleId": booking.scheduleId,
      "schedule": booking.schedule,
      "user": booking.user
    };
    var req = http.Request('PATCH', url);
    req.headers.addAll(headersList);
    req.body = json.encode(body);

    var res = await req.send();
    final resBody = await res.stream.bytesToString();

    if (res.statusCode >= 200 && res.statusCode < 300) {
      print(resBody);
    }
    else {
      throw Exception('Failed to update bookings.');
    }
  }

  @override
  Future<BookingMovie?> getBooking(String id) async {
    User userOut = await localDbProvider.getUser();

    var headersList = {
      'Accept': '*/*',
      "Authorization": "Bearer ${userOut.loginToken}",
      'Content-Type': 'application/json'
    };
    var url = Uri.parse('${ApiData.baseUrl}/bookings');

    var body = {

    };
    var req = http.Request('GET', url);
    req.headers.addAll(headersList);
    req.body = json.encode(body);

    var res = await req.send();
    final resBody = await res.stream.bytesToString();

    if (res.statusCode >= 200 && res.statusCode < 300) {
      final List bookings = json.decode(resBody);

      for (int i = 0; i < bookings.length; i++) {
        if (bookings[i].id == id) {
          return bookings[i];
        }
      }
    } else {
      throw Exception();
    }
  }

  @override
  Future<List<BookingResponse>> getAllBookings() async {

    User userOut = await localDbProvider.getUser();

    var headersList = {
      'Accept': '*/*',
      "Authorization": "Bearer ${userOut.loginToken}",
      'Content-Type': 'application/json'
    };

    final response = await http.get(Uri.parse('${ApiData.baseUrl}/users/${userOut.id}/bookings'),
        headers: headersList);

    if (response.statusCode == 200) {

      final bookingList = jsonDecode(response.body);

      List<BookingResponse> fetchedList = [];

      for (var key in bookingList.keys) {

        List<BookingMovie> listBooking = [];

        for (var booking in bookingList[key]) {
          listBooking.add(BookingMovie.fromJson(booking));
        }

        fetchedList.add(BookingResponse(date: key, bookings: listBooking));
      }

      // print(fetchedList[0].bookings[0].movie);

      return fetchedList;
    } else {
      throw Exception('Failed to load bookings');
    }
  }
}
