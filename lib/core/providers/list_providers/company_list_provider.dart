import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:odyss/core/constraints.dart';
import 'package:odyss/data/models/company_model.dart';
 // Update this to your actual endpoint

final partnerListProvider = FutureProvider<List<PartnerModel>>((ref) async {
  final token = await secureStorage.read(key: 'access_token');
  final response = await http.get(
    Uri.parse(partnerUrl),
    headers: {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    },
  );
  if (response.statusCode == 200) {
    final List<dynamic> data = jsonDecode(response.body);
    print('list Companies: $data');
    return data.map((e) => PartnerModel.fromJson(e)).toList();
  } else {
    throw Exception('Failed to fetch companies: ${response.body}');
  }
});