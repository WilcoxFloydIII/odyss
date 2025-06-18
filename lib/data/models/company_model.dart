class PartnerModel {
  late String name;
  late List<VehicleModel> vehicles;
  late List<String> locations;

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

  VehicleModel({required this.type, required this.seats, required this.price,});
}
