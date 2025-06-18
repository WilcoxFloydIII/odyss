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
  late final String password;
  late final List<String> vibes;
  late final List rides;
  late final String insta;
  late final String tiktok;
  late final String x;
  late final String fb;
  late final String bio;

  UserModel({
    required this.id,
    required this.bio,
    required this.x,
    required this.fb,
    required this.tiktok,
    required this.insta,
    required this.nickName,
    required this.firstName,
    required this.lastName,
    required this.middleName,
    required this.video,
    required this.picture,
    required this.number,
    required this.email,
    required this.password,
    required this.vibes,
    required this.rides,
  });
}
