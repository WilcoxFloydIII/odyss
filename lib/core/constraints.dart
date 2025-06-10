bool signedIn = true;

initLocationFunc() {
  if (signedIn == false) {
    return '/';
  } else {
    return '/rides';
  }
}
