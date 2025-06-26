class RouteModel {
  late String companyId;
  late String departureLocation;
  late String arrivalLocation;
  late DateTime duration;
  late List<DateTime> departureTime;
  late List<VehicleModel> vehicles;

  RouteModel({
    required this.companyId,
    required this.arrivalLocation,
    required this.departureLocation,
    required this.departureTime,
    required this.duration,
    required this.vehicles,
  });
}

class VehicleModel {
  late String type;
  late String seats;
  late String price;

  VehicleModel({required this.type, required this.seats, required this.price});
}
