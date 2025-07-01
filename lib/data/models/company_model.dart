class PartnerModel {
  late String id;
  // late String picture;
  late String name;

  PartnerModel({required this.id, required this.name});

  factory PartnerModel.fromJson(Map<String, dynamic> json) {
    return PartnerModel(
      id: json['id'] as String,
      // picture: json['picture'] as String,
      name: json['company_name'] as String,
    );
  }
}
