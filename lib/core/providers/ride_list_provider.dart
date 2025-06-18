import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:odyss/data/models/ride_model.dart';

var ridesListProvider = StateProvider<List<RideModel>>(
  (ref) => [
    RideModel(
      memberIds: ['xxxx1', 'xxxx2', 'xxxx3'],
      seats: 6,
      company: 'Peace Mass Transit',
      price: 18000,
      days: 3,
      departureLoc: 'Enugu',
      arrivalLoc: 'Abuja',
      arrivalDate: DateTime(2025, 5, 8, 14, 0),
      departureDate: DateTime(2025, 5, 8, 9, 0),
      vehicle: 'Sienna',
      departureTOD: 'Morning', id: '',
    ),
    RideModel(
      memberIds: ['xxxx4', 'xxxx5', 'xxxx6', 'xxxx7'],
      seats: 11,
      company: 'God Is Good Motors',
      price: 10000,
      days: 7,
      departureLoc: 'Enugu',
      arrivalLoc: 'Lagos',
      arrivalDate: DateTime(2025, 7, 9, 15, 0),
      departureDate: DateTime(2025, 9, 7, 7, 0),
      vehicle: 'Bus',
      departureTOD: 'Morning', id: '',
    ),
  ],
);

final departureQueryProvider = StateProvider<String>((ref) => '');
final arrivalQueryProvider = StateProvider<String>((ref) => '');
final dateQueryProvider = StateProvider<String>((ref) => '');
final timeQueryProvider = StateProvider<String>((ref) => '');

final filteredRidesProvider = StateProvider<List<RideModel>>((ref) {
  final rides = ref.watch(ridesListProvider);
  final depQuery = ref.watch(departureQueryProvider).toLowerCase();
  final arrQuery = ref.watch(arrivalQueryProvider).toLowerCase();
  final dateQuery = ref.watch(dateQueryProvider).toLowerCase();
  final timeQuery = ref.watch(timeQueryProvider).toLowerCase();

  // If any search field has input, perform filtering
  if (depQuery.isNotEmpty ||
      arrQuery.isNotEmpty ||
      dateQuery.isNotEmpty ||
      timeQuery.isNotEmpty) {
    // Filter rides based on all criteria
    final filtered = rides.where((ride) {
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

    return filtered; // returns empty list if nothing matches
  }

  // If no search terms provided, return full list
  return rides;
});
