class CircleModel {
  late String id;
  late String name;
  late String description;
  late String departure;
  late String destination;
  late DateTime startDate;
  late DateTime endDate;
  late List<String> users;

  CircleModel({
    required this.id,
    required this.name,
    required this.description,
    required this.departure,
    required this.destination,
    required this.startDate,
    required this.endDate,
    required this.users,
  });

  factory CircleModel.fromJson(Map<String, dynamic> json) {
    return CircleModel(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      departure: json['departure'] as String,
      destination: json['destination'] as String,
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
      users: List<String>.from(json['users'] as List),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'departure': departure,
      'destination': destination,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'users': users,
    };
  }
}
