class UserModel {
  late final String id;
  late final String nickName;
  late final String firstName;
  late final String lastName;
  late final String middleName;
  late final String video;
  late final String picture;
  late final String number;
  late final String email;
  late final List<String> vibes;
  late final List rides;

  UserModel({
    required this.id,
    required this.nickName,
    required this.firstName,
    required this.lastName,
    required this.middleName,
    required this.video,
    required this.picture,
    required this.number,
    required this.email,
    required this.vibes,
    required this.rides,
  });
}
