bool signedIn = false;

bool videoSet = false;

String requestOTP = 'https://server.odyss.ng/auth/request-otp';
String verifyOTP = 'https://server.odyss.ng/auth/verify-otp';
String register = 'https://server.odyss.ng/auth/register';

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
  'intro_video': '',
  'date_of_birth': '',
  'vibes': [],
};
