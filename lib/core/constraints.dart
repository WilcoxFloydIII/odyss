bool signedIn = true;

bool videoSet = false;

initLocationFunc() {
  if (signedIn == false) {
    return '/start';
  } else {
    return '/rides';
  }
}

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

late String UID = 'xxxx1';

Map<String, dynamic> newUser = {
  'firstName': '',
  'lastName': '',
  'nickname': '',
  'email': '',
  'bio': '',
  'phone': '',
  'password': '',
  'picture': '',
  'video': '',
  'DOB': '',
  'vibes' : [],
};
