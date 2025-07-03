import 'package:intl/intl.dart';

class RouteModel {
  late String id;
  late String terminal;
  late String companyId;
  late String departureLocation;
  late String arrivalLocation;
  // late DateTime duration;
  late String price;
  late List<DateTime> departureTime;
  late List<String> vehicles;

  RouteModel({
    required this.id,
    required this.terminal,
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
      id: json['id']?.toString() ?? '',
      terminal: json['terminal']?.toString() ?? '',
      companyId: json['company_id']?.toString() ?? '',
      price: json['price']?.toString() ?? '',
      arrivalLocation: json['destination']?.toString() ?? '',
      departureLocation: json['origin']?.toString() ?? '',
      // duration: DateTime.parse(json['duration'] as String),
      departureTime: (() {
        final depTime = json['dep_time'];
        if (depTime is List) {
          return depTime.map<DateTime>((e) {
            try {
              return DateTime.parse(e.toString());
            } catch (_) {
              // Try parsing as time-only (e.g., "08:00 AM")
              return DateFormat.jm().parse(e.toString());
            }
          }).toList();
        } else if (depTime is String) {
          try {
            return [DateTime.parse(depTime)];
          } catch (_) {
            // Try parsing as time-only (e.g., "08:00 AM")
            return [DateFormat.jm().parse(depTime)];
          }
        } else {
          return <DateTime>[];
        }
      })(),
      vehicles:
          (json['vehicles'] as List<dynamic>?)
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
