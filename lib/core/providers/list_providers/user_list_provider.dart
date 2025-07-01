import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:odyss/core/constraints.dart';
import 'package:odyss/data/models/user_model.dart';

final userListProvider = FutureProvider<List<UserModel>>((ref) async {
  final token = await secureStorage.read(key: 'access_token');
  final response = await http.get(
    Uri.parse(usersUrl2),
    headers: {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    },
  );
  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    if (data is List) {
      // Root is a list
      return data.map<UserModel>((e) => UserModel.fromJson(e)).toList();
    } else if (data is Map && data['users'] is List) {
      // Root is a map with a 'users' key
      return (data['users'] as List)
          .map<UserModel>((e) => UserModel.fromJson(e))
          .toList();
    } else {
      throw Exception('Invalid data format for users');
    }
  } else {
    print(response.body);
    throw Exception('Failed to fetch users');
  }
});
