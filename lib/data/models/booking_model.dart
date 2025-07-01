class BookingModel {
  late String id;
  late String rideId;
  late String userId;
  late int seats;
  late String status; // 'pending', 'confirmed', 'cancelled'
  late DateTime bookingDate;

  BookingModel({
    required this.id,
    required this.rideId,
    required this.userId,
    required this.seats,
    required this.status,
    required this.bookingDate,
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
      id: json['id'] as String,
      rideId: json['rideId'] as String,
      userId: json['userId'] as String,
      seats: json['seats'] as int,
      status: json['status'] as String,
      bookingDate: DateTime.parse(json['bookingDate'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'rideId': rideId,
      'userId': userId,
      'seats': seats,
      'status': status,
      'bookingDate': bookingDate.toIso8601String(),
    };
  }
}
