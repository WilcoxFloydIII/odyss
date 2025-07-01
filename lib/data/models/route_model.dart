class RouteModel {
  late String companyId;
  late String departureLocation;
  late String arrivalLocation;
  // late DateTime duration;
  late String price;
  late List<DateTime> departureTime;
  late List<String> vehicles;

  RouteModel({
    required this.companyId,
    required this.arrivalLocation,
    required this.departureLocation,
    required this.departureTime,
    // required this.duration,
    required this.price,
    required this.vehicles,
  });

  factory RouteModel.fromJson(Map<String, dynamic> json) {
    return RouteModel(
      companyId: json['company_id']?.toString() ?? '',
      price: json['price']?.toString() ?? '',
      arrivalLocation: json['destination']?.toString() ?? '',
      departureLocation: json['origin']?.toString() ?? '',
      // duration: DateTime.parse(json['duration'] as String),
      departureTime:
          (json['dep_time'] as List?)
              ?.map<DateTime>((e) => DateTime.parse(e.toString()))
              .toList() ??
          [],
      vehicles:
          (json['vehicles'] as List?)
              ?.map<String>((e) => e.toString())
              .toList() ??
          [],
    );
  }
}

class VehicleModel {
  late String id;
  late String companyId;
  late String type;
  late String seats;

  VehicleModel({
    required this.id,
    required this.companyId,
    required this.type,
    required this.seats,
  });

  factory VehicleModel.fromJson(Map<String, dynamic> json) {
    return VehicleModel(
      id: json['id']?.toString() ?? '',
      companyId: json['company_id']?.toString() ?? '',
      type: json['type']?.toString() ?? '',
      seats: json['capacity']?.toString() ?? '',
    );
  }
}