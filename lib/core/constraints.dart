bool signedIn = true;

initLocationFunc() {
  if (signedIn == false) {
    return '/satrt';
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
  'phone': '',
  'password': '',
  'picture': '',
  'video': '',
  'DOB': '',
  '': '',
};
