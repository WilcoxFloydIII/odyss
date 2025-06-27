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
  final String creator;
  final bool fill;

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
    required this.creator,
    required this.fill,
  });

  factory RideModel.fromJson(Map<String, dynamic> json) {
    return RideModel(
      id: json['id'] ?? '',
      vehicle: json['vehicle'] ?? '',
      memberIds: List<String>.from(json['memberIds'] ?? []),
      seats: json['seats'] ?? 0,
      company: json['company'] ?? '',
      price: json['price'] ?? 0,
      days: json['days'] ?? 0,
      departureLoc: json['departureLoc'] ?? '',
      arrivalLoc: json['arrivalLoc'] ?? '',
      departureTOD: json['departureTOD'] ?? '',
      departureDate: DateTime.parse(json['departureDate'] ?? DateTime.now().toString()),
      arrivalDate: DateTime.parse(json['arrivalDate'] ?? DateTime.now().toString()),
      creator: json['creator'] ?? '',
      fill: json['fill'] ?? false,
    );
  }

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
      days: days ?? this.days,
      departureLoc: departureLoc ?? this.departureLoc,
      arrivalLoc: arrivalLoc ?? this.arrivalLoc,
      departureTOD: departureTOD ?? this.departureTOD,
      departureDate: departureDate ?? this.departureDate,
      arrivalDate: arrivalDate ?? this.arrivalDate,
      creator: creator?? this.creator,
      fill: fill ?? this.fill,
    );
  }
}
