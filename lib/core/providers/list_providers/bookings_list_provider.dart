import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:odyss/data/models/booking_model.dart';

final bookingsListProvider = FutureProvider<List<BookingModel>>((ref) async {
  final response = await http.get(Uri.parse('/bookings'));
  if (response.statusCode == 200) {
    final List<dynamic> data = jsonDecode(response.body);
    return data.map((e) => BookingModel.fromJson(e)).toList();
  } else {
    throw Exception('Failed to load bookings');
  }
});
