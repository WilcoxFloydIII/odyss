import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:odyss/data/models/circle_model.dart';

// Replace with your actual API endpoint
const String circlesUrl = 'https://your-api-url.com/circles';

final CircleListProvider = FutureProvider<List<CircleModel>>((ref) async {
  final response = await http.get(Uri.parse(circlesUrl));
  if (response.statusCode == 200) {
    final List<dynamic> data = jsonDecode(response.body);
    return data.map((e) => CircleModel.fromJson(e)).toList();
  } else {
    throw Exception('Failed to fetch circles: ${response.body}');
  }
});
