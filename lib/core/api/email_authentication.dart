import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:odyss/core/constraints.dart';

Future<bool> sendOtpRequest(String email) async {
  final response = await http.post(
    Uri.parse(requestOTP),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({'email': email}),
  );

  return response.statusCode == 200;
}

Future<bool> verifyOtp(String email, String otp) async {
  final response = await http.post(
    Uri.parse(verifyOTP),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({'email': email, 'otp': otp}),
  );

  final data = jsonDecode(response.body);
  return response.statusCode == 200 && data['valid'] == true;
}

Future<bool> registerUser(Map<String, dynamic> newUser) async {
  final response = await http.post(
    Uri.parse(register),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode(newUser),
  );

  return response.statusCode == 201;
}

