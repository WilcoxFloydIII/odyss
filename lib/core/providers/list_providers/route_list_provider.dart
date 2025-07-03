import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:odyss/core/constraints.dart';
import 'package:odyss/data/models/route_model.dart';

final routesListProvider = FutureProvider<List<RouteModel>>((ref) async {
  final token = await secureStorage.read(key: 'access_token');
  final response = await http.get(
    Uri.parse(routesUrl),
    headers: {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    },
  );
  if (response.statusCode == 200) {
    final decoded = jsonDecode(response.body);
    if (decoded is List) {
      print('list Routes: $decoded');
      return decoded.map((e) => RouteModel.fromJson(e)).toList();
    } else if (decoded is Map && decoded.containsKey('error')) {
      print('Routes: $decoded');
      throw Exception(decoded['error']);
    } else if (decoded is String) {
      print('Routes: $decoded');
      throw Exception('Failed to fetch routes: $decoded');
    } else {
      print('Routes: $decoded');
      throw Exception('Unexpected response format');
    }
  } else {
    print('Failed to fetch routes: ${response.body}');
    throw Exception('Failed to fetch routes: ${response.body}');
  }
});

final vehiclesListProvider = FutureProvider<List<VehicleModel>>((ref) async {
  final token = await secureStorage.read(key: 'access_token');
  final response = await http.get(
    Uri.parse(vehiclesUrl),
    headers: {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    },
  );
  if (response.statusCode == 200) {
    final decoded = jsonDecode(response.body);
    if (decoded is List) {
      print('list Vehicles: $decoded');
      return decoded.map((e) => VehicleModel.fromJson(e)).toList();
    } else if (decoded is Map && decoded.containsKey('error')) {
      print('Vehicles: $decoded');
      throw Exception('Failed to fetch vehicles${decoded['error']}');
    } else if (decoded is String) {
      print('Vehicles: $decoded');
      throw Exception(decoded);
    } else {
      print('Vehicles: $decoded');
      throw Exception('Unexpected response format');
    }
  } else {
    print('Failed to fetch vehicles: ${response.body}');
    throw Exception('Failed to fetch vehicles: ${response.body}');
  }
});
