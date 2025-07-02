class UserModel {
  late final String id;
  late final String nickName;
  late final String firstName;
  late final String lastName;
  late final String video;
  late final String picture;
  late final String number;
  late final String email;
  late final String password;
  late final List<String> vibes;
  late final List rides;
  final String? insta;
  final String? tiktok;
  final String? x;
  final String? fb;
  late final String bio;

  UserModel({
    this.x,
    this.fb,
    this.tiktok,
    this.insta,
    required this.id,
    required this.bio,
    required this.nickName,
    required this.firstName,
    required this.lastName,
    required this.video,
    required this.picture,
    required this.number,
    required this.email,
    required this.password,
    required this.vibes,
    // required this.rides,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      x: json['x'],
      fb: json['fb'],
      tiktok: json['tiktok'],
      insta: json['insta'],
      id: json['id'] ?? '',
      bio: json['bio'] ?? '',
      nickName: json['nickname'] ?? '',
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      video: json['intro_video'] ?? '',
      picture: json['avatar'] ?? '',
      number: json['phone_number'] ?? '',
      email: json['email'] ?? '',
      password: json['password'] ?? '',
      vibes: List<String>.from(json['vibes'] ?? []),
      // rides: json['rides'] ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'x': x,
      'fb': fb,
      'tiktok': tiktok,
      'insta': insta,
      'id': id,
      'bio': bio,
      'nickname': nickName,
      'first_name': firstName,
      'last_name': lastName,
      'intro_video': video,
      'avatar': picture,
      'phone_number': number,
      'email': email,
      'password': password,
      'vibes': vibes,
      // 'rides': rides,
    };
  }
}
