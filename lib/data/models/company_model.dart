class PartnerModel {
  late String name;
  late List<VehicleModel> vehicles;
  late List<String> locations;
  late List<LocationModel> places;
  late List<RouteModel> routes;

  PartnerModel({
    required this.name,
    required this.vehicles,
    required this.locations,
  });
}

class VehicleModel {
  late String type;
  late String seats;
  late String price;

  VehicleModel({required this.type, required this.seats, required this.price});
}

class LocationModel {
  late String state;
  late List<String> terminals;
}

class RouteModel {
  late String departureLocation;
  late String arrivalLocation;
  late String distance;
  late String duration;
  late List<DateTime> times;
}
