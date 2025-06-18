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

  get departureLocation => null;
}
