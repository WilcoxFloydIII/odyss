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

  CircleModel copyWith({
    String? id,
    String? name,
    String? description,
    String? departure,
    String? destination,
    DateTime? startDate,
    DateTime? endDate,
    List<String>? users,
  }) {
    return CircleModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description?? this.description,
      departure: departure ?? this.departure,
      destination: destination ?? this.destination,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      users: users ?? this.users,
    );
  }
}
