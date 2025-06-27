import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:odyss/data/models/ride_model.dart';

class RideListNotifier extends StateNotifier<List<RideModel>> {
  RideListNotifier()
    : super([]);

  void addRide(RideModel ride) {
    state = [...state, ride];
  }

  void updateRide(
    String id, {
    List? memberIds,
    int? seats,
    String? company,
    int? price,
    int? days,
    String? departureLoc,
    String? arrivalLoc,
    DateTime? departureDate,
    DateTime? arrivalDate,
    String? departureTOD,
    String? vehicle,
  }) {
    state = state.map((ride) {
      if (ride.id == id) {
        return ride.copyWith(
          id: id,
          vehicle: vehicle,
          memberIds: memberIds,
          seats: seats,
          company: company,
          price: price,
          days: days,
          departureLoc: departureLoc,
          arrivalLoc: arrivalLoc,
          departureTOD: departureTOD,
          departureDate: departureDate,
          arrivalDate: arrivalDate,
        );
      }
      return ride;
    }).toList();
  }
}

var ridesListProvider =
    StateNotifierProvider<RideListNotifier, List<RideModel>>(
      (ref) => RideListNotifier(),
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

List rides = [];
