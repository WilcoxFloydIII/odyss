import 'package:odyss/data/models/user_model.dart';

bool signedIn = false;

initLocationFunc() {
  if (signedIn == false) {
    return '/';
  } else {
    return '/rides';
  }
}

late UserModel currentUser;

Map<String, dynamic> user = {'FN': '', 'LN': '', 'DOB' : '',};


