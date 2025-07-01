import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:odyss/data/models/ride_model.dart';
import 'package:odyss/core/constraints.dart'; // Make sure tripsUrl2 is defined here

final ridesListProvider = FutureProvider<List<RideModel>>((ref) async {
  final response = await http.get(Uri.parse(tripsUrl2));
  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    final tripsList = data['trips'];
    if (tripsList is List) {
      return tripsList.map<RideModel>((e) => RideModel.fromJson(e)).toList();
    } else {
      throw Exception('Invalid data format: "trips" is not a list.');
    }
  } else {
    throw Exception('Failed to fetch rides: ${response.body}');
  }
});

final departureQueryProvider = StateProvider<String>((ref) => '');
final arrivalQueryProvider = StateProvider<String>((ref) => '');
final dateQueryProvider = StateProvider<String>((ref) => '');
final timeQueryProvider = StateProvider<String>((ref) => '');

final filteredRidesProvider = FutureProvider<List<RideModel>>((ref) async {
  final ridesAsync = await ref.watch(ridesListProvider.future);
  final depQuery = ref.watch(departureQueryProvider).toLowerCase();
  final arrQuery = ref.watch(arrivalQueryProvider).toLowerCase();
  final dateQuery = ref.watch(dateQueryProvider).toLowerCase();
  final timeQuery = ref.watch(timeQueryProvider).toLowerCase();

  if (depQuery.isNotEmpty ||
      arrQuery.isNotEmpty ||
      dateQuery.isNotEmpty ||
      timeQuery.isNotEmpty) {
    return ridesAsync.where((ride) {
      final matchesDeparture =
          depQuery.isEmpty ||
          ride.departureLoc.toLowerCase().contains(depQuery);
      final matchesArrival =
          arrQuery.isEmpty || ride.arrivalLoc.toLowerCase().contains(arrQuery);

      final formattedDate =
          '${ride.departureDate.day}/${ride.departureDate.month}/${ride.departureDate.year}';
      final matchesDate =
          dateQuery.isEmpty || formattedDate.contains(dateQuery);

      final matchesTime =
          timeQuery.isEmpty ||
          ride.departureTOD.toLowerCase().contains(timeQuery);

      return matchesDeparture && matchesArrival && matchesDate && matchesTime;
    }).toList();
  }
  return ridesAsync;
});
