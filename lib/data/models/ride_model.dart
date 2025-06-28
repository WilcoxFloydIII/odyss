class RideModel {
  final String id;
  final List memberIds;
  final int seats;
  final String company;
  final int price;
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

  RideModel copyWith({
    String? id,
    List<String>? vibes,
    List? memberIds,
    int? seats,
    String? company,
    int? price,
    String? departureLoc,
    String? arrivalLoc,
    DateTime? departureDate,
    DateTime? arrivalDate,
    String? departureTOD,
    String? vehicle,
    String? creator,
    bool? fill,
  }) {
    return RideModel(
      id: id ?? this.id,
      vehicle: vehicle ?? this.vehicle,
      memberIds: memberIds ?? this.memberIds,
      seats: seats ?? this.seats,
      company: company ?? this.company,
      price: price ?? this.price,
      departureLoc: departureLoc ?? this.departureLoc,
      arrivalLoc: arrivalLoc ?? this.arrivalLoc,
      departureTOD: departureTOD ?? this.departureTOD,
      departureDate: departureDate ?? this.departureDate,
      arrivalDate: arrivalDate ?? this.arrivalDate,
      creator: creator ?? this.creator,
      fill: fill ?? this.fill,
      vibes: vibes ?? this.vibes,
    );
  }

  Map<String, dynamic> toJson() {
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
