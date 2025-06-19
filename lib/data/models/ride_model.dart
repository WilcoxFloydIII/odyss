class RideModel {
  final String id;
  final List memberIds;
  final int seats;
  final String company;
  final int price;
  final int days;
  final String departureLoc;
  final String arrivalLoc;
  final DateTime departureDate;
  final DateTime arrivalDate;
  final String departureTOD;
  final String vehicle;

  RideModel({
    required this.id,
    required this.vehicle,
    required this.memberIds,
    required this.seats,
    required this.company,
    required this.price,
    required this.days,
    required this.departureLoc,
    required this.arrivalLoc,
    required this.departureTOD,
    required this.departureDate,
    required this.arrivalDate,
  });

  RideModel copyWith({
    String? id,
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
    return RideModel(
      id: id ?? this.id,
      vehicle: vehicle ?? this.vehicle,
      memberIds: memberIds ?? this.memberIds,
      seats: seats ?? this.seats,
      company: company ?? this.company,
      price: price ?? this.price,
      days: days ?? this.days,
      departureLoc: departureLoc ?? this.departureLoc,
      arrivalLoc: arrivalLoc ?? this.arrivalLoc,
      departureTOD: departureTOD ?? this.departureTOD,
      departureDate: departureDate ?? this.departureDate,
      arrivalDate: arrivalDate ?? this.arrivalDate,
    );
  }
}
