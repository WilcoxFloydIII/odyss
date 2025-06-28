import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:odyss/core/constraints.dart';
import 'package:odyss/data/models/ride_model.dart';
import 'package:odyss/screens/curate_trip_screen/paystack_webview_page.dart';
import 'package:odyss/screens/error_dialog_widget.dart';
import 'package:odyss/screens/loading_animation_widget.dart';

Future<void> initiateTripAndPay({
  required BuildContext context,
  required RideModel ride,
  required String userEmail,
}) async {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) => const LoadingAnimationWidget(),
  );

  try {
    final token = await secureStorage.read(key: 'access_token');
    if (token == null) throw Exception('User not authenticated');

    final response = await http.post(
      Uri.parse(tripsUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(ride.toJson(email: userEmail)),
    );

    Navigator.pop(context); // Remove loading

    if (response.statusCode != 200) {
      final error = jsonDecode(response.body)['message'] ?? 'Trip init failed';
      throw Exception(error);
    }

    final data = jsonDecode(response.body);
    final reference = data['reference']; // Rename for clarity
    final amount = data['amount'];
    final currency = data['currency'];

    final authorizationUrl = data['authorization_url'];
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => PaystackWebViewPage(paystackUrl: authorizationUrl, ride: ride, reference: reference),
      ),
    );
  } catch (e) {
    showDialog(
      context: context,
      builder: (_) => ErrorDialogWidget(error: e.toString()),
    );
  }
}
