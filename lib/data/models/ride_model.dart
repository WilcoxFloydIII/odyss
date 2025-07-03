class RideModel {
  final String id;
  final List memberIds;
  final int seats;
  final String company;
  final double price;
  final String departureLoc;
  final String arrivalLoc;
  final DateTime departureDate;
  final DateTime arrivalDate;
  final String departureTOD;
  final String vehicle;
  final String creator;
  final bool fill;
  final List vibes;

  RideModel({
    required this.id,
    required this.vehicle,
    required this.memberIds,
    required this.seats,
    required this.company,
    required this.price,
    required this.departureLoc,
    required this.arrivalLoc,
    required this.departureTOD,
    required this.departureDate,
    required this.arrivalDate,
    required this.creator,
    required this.fill,
    required this.vibes,
  });

  factory RideModel.fromJson(Map<String, dynamic> json) {
    return RideModel(
      id: json['id'] ?? '',
      vehicle: json['vehicle'] ?? '',
      memberIds: List<String>.from(json['memberIds'] ?? []),
      seats: json['seats'] ?? 0,
      company: json['company'] ?? '',
      price: json['price'] ?? 0,
      departureLoc: json['departureLoc'] ?? '',
      arrivalLoc: json['arrivalLoc'] ?? '',
      departureTOD: json['departureTOD'] ?? '',
      departureDate: DateTime.parse(
        json['departureDate'] ?? DateTime.now().toString(),
      ),
      arrivalDate: DateTime.parse(
        json['arrivalDate'] ?? DateTime.now().toString(),
      ),
      creator: json['creator'] ?? '',
      fill: json['fill'] ?? false,
      vibes: List<String>.from(json['vibes'] ?? []),
    );
  }

  Map<String, dynamic> toJson({required String email}) {
    // Ensure memberIds is a list of strings
    return {
      'vehicle': vehicle,
      'memberIds': memberIds,
      'seats': seats,
      'company': company,
      'price': price,
      'departureLoc': departureLoc,
      'arrivalLoc': arrivalLoc,
      'departureTOD': departureTOD,
      'departureDate': departureDate.toIso8601String(),
      'arrivalDate': arrivalDate.toIso8601String(),
      'creator': creator,
      'fill': fill,
      'vibes': vibes,
      'email': email,
    };
  }

  Map<String, dynamic> toTripJson() {
    // Ensure memberIds is a list of strings
    return {
      'vehicle': vehicle,
      'memberIds': memberIds,
      'seats': seats,
      'company': company,
      'price': price,
      'departureLoc': departureLoc,
      'arrivalLoc': arrivalLoc,
      'departureTOD': departureTOD,
      'departureDate': departureDate.toIso8601String(),
      'arrivalDate': arrivalDate.toIso8601String(),
      'creator': creator,
      'fill': fill,
      'vibes': vibes,
    };
  }
}
