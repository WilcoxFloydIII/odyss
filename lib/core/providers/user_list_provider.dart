import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:odyss/data/models/user_model.dart';

class UserListNotifier extends StateNotifier<List<UserModel>> {
  UserListNotifier()
    : super([
       
      ]);

  void addUser(UserModel user) {
    state = [...state, user];
  }

  void updateUser(
    String id, {
    String? nickName,
    String? firstName,
    String? lastName,
    String? video,
    String? picture,
    String? number,
    String? email,
    String? password,
    List<String>? vibes,
    List? rides,
    // String? insta,
    // String? tiktok,
    // String? x,
    // String? fb,
    String? bio,
  }) {
    state = state.map((user) {
      if (user.id == id) {
        return user.copyWith(
          id: id,
          bio: bio,
          // x: x,
          // fb: fb,
          // tiktok: tiktok,
          // insta: insta,
          nickName: nickName,
          firstName: firstName,
          lastName: lastName,
          video: video,
          picture: picture,
          number: number,
          email: email,
          password: password,
          vibes: vibes,
          rides: rides,
        );
      }
      return user;
    }).toList();
  }
}

final userListProvider =
    StateNotifierProvider<UserListNotifier, List<UserModel>>(
      (ref) => UserListNotifier(),
    );

