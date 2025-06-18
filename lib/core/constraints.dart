import 'package:odyss/data/models/user_model.dart';

bool signedIn = true;

initLocationFunc() {
  if (signedIn == false) {
    return '/';
  } else {
    return '/profile';
  }
}

late UserModel currentUser;

Map<String, dynamic> user = {'FN': '', 'LN': '', 'DOB': ''};

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

String UID = 'xxxx1';
