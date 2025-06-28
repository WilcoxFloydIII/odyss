import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:odyss/core/constraints.dart';
import 'package:odyss/data/models/ride_model.dart';
import 'package:odyss/screens/error_dialog_widget.dart';
import 'package:odyss/screens/loading_animation_widget.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaystackWebViewPage extends StatefulWidget {
  final String paystackUrl;
  final RideModel ride;
  final String reference;

  const PaystackWebViewPage({
    super.key,
    required this.paystackUrl,
    required this.ride,
    required this.reference,
  });

  @override
  State<PaystackWebViewPage> createState() => _PaystackWebViewPageState();
}

class _PaystackWebViewPageState extends State<PaystackWebViewPage> {
  late final WebViewController _controller;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onNavigationRequest: (request) async {
            final url = request.url;
            if (url.contains('/payments/success')) {
              // Optionally extract reference or other params from the URL here

              // Call your verify endpoint
              await _verifyPayment();
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.paystackUrl));
  }

  Future<void> _verifyPayment() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final response = await http.post(
        Uri.parse('https://server.odyss.ng/payments/verify-trip'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization':
              'Bearer ${await secureStorage.read(key: 'access_token')}',
          // Add any other necessary headers here
        },
        body: jsonEncode({
          'reference': widget.reference,
          'trip' : widget.ride.toTripJson(),
          // Replace with actual reference
          // Add other necessary fields for verification
        }),
        // headers and body as needed
      );
      // Optionally handle response
      print('Verify response: ${response.statusCode} ${response.body}');
      if (response.statusCode == 201) {
        context.go('/allSet');
      } else {
        print('Verification failed: ${response.body}');
        showDialog(
          context: context,
          builder: (_) => ErrorDialogWidget(error: response.body),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pay for Trip')),
      body: Stack(
        children: [
          WebViewWidget(controller: _controller),
          if (_isLoading)
            Container(
              color: Colors.black.withOpacity(0.3),
              child: const Center(child: LoadingAnimationWidget()),
            ),
        ],
      ),
    );
  }
}
