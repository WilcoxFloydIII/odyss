import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

String requestOTP = 'https://server.odyss.ng/auth/request-otp';
String verifyOTP = 'https://server.odyss.ng/auth/verify-otp';
String register = 'https://server.odyss.ng/auth/register';
String login = 'https://server.odyss.ng/auth/login';
String usersUrl = 'https://server.odyss.ng/users/me';
String usersUrl2 = 'https://server.odyss.ng/users';
String tripsUrl = 'https://server.odyss.ng/payments/initiate-trip';
String tripsUrl2 = 'https://server.odyss.ng/trips';
String partnerUrl = 'https://server.odyss.ng/users/companies';
String routesUrl = 'https://server.odyss.ng/users/company_routes';
String vehiclesUrl = 'https://server.odyss.ng/users/company_vehicles';
String circlesUrl = 'https://server.odyss.ng/users/circles';
String circleUrl = 'https://server.odyss.ng/users/circle';
// String initPayment = 'https://server.odyss.ng/payments/initiate';
// String verifyPayment = 'https://server.odyss.ng/payments/verify';

final supabase = SupabaseClient(
  'https://vxsikirblhcmcjmsoyvz.supabase.co',
  'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InZ4c2lraXJibGhjbWNqbXNveXZ6Iiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc0NzYxNDQ1NSwiZXhwIjoyMDYzMTkwNDU1fQ.c04bo4Kcpjfv4M0R2wxr8hkWJVnnmpggz12th4ZfQGA',
);

Future<String> uploadFileToSupabase(File file, String path) async {
  final supabase = Supabase.instance.client;
  final fileBytes = await file.readAsBytes();
  final fileName =
      '$path/${DateTime.now().millisecondsSinceEpoch}_${file.path.split('/').last}';

  final response = await supabase.storage
      .from('user-media')
      .uploadBinary(
        fileName,
        fileBytes,
        fileOptions: const FileOptions(upsert: true),
      );

  if (response.isEmpty) throw Exception('Upload failed');
  return supabase.storage.from('user-media').getPublicUrl(fileName);
}

final secureStorage = FlutterSecureStorage();

Future<SharedPreferences> getSharedPrefs() async {
  return await SharedPreferences.getInstance();
}

Map<String, dynamic> newRide = {
  'depLoc': '',
  'destLoc': '',
  'date': DateTime,
  'time': DateTime,
  'partner': '',
  'vehicle': '',
  'seats': '',
  'vibes': [],
  'price': '',
  'members': [],
  'fill': false,
};

late String UID;

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
  'access_code': '',
};
