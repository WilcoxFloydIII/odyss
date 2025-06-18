import 'package:http/http.dart' as http;
import 'dart:convert';

Future<void> submitData() async {
  final url = Uri.parse('https://odyssdev.onrender.com/api/v1/auth/register');

  final response = await http.post(
    url,
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({"email":"lilice308@gmail.com", "password" : "password"}),
  );

  if (response.statusCode == 200) {
    print('Success: ${response.body}');
  } else {
    print('Error: ${response.statusCode}');
  }
}
