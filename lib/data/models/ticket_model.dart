class TicketModel {
  late String id;
  late int seats;
  late String company;
  late int price;
  late int days;
  late String departureLoc;
  late String arrivalLoc;
  late DateTime departureDate;
  late DateTime arrivalDate;
  late String vehicle;

  TicketModel({
    required this.id,
    required this.seats,
    required this.company,
    required this.price,
    required this.days,
    required this.departureLoc,
    required this.arrivalLoc,
    required this.departureDate,
    required this.arrivalDate,
    required this.vehicle,
  });
}
