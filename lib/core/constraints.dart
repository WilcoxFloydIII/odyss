import 'package:odyss/data/models/user_model.dart';

bool signedIn = false;

initLocationFunc() {
  if (signedIn == false) {
    return '/';
  } else {
    return '/profile';
  }
}

late UserModel currentUser;

Map<String, dynamic> newRide = {
  'depLoc': '',
  'destLoc': '',
  'time': '',
  'partner': '',
  'vehicle': '',
  'seats': '',
  'vibes': [],
  'price': '',
  'members': [],
};

late String UID;
