import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:odyss/core/colors.dart';
import 'package:odyss/core/constraints.dart';
import 'package:odyss/screens/error_dialog_widget.dart';
import 'package:odyss/screens/loading_animation_widget.dart';

class EmailConfirmationScreen extends StatefulWidget {
  const EmailConfirmationScreen({super.key, r});

  @override
  State<EmailConfirmationScreen> createState() =>
      _EmailConfirmationScreenState();
}

class _EmailConfirmationScreenState extends State<EmailConfirmationScreen> {
  static const int _initialSeconds = 60;
  int _remainingSeconds = _initialSeconds;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startCountdown();
  }

  void _startCountdown() {
    _remainingSeconds = _initialSeconds;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds == 0) {
        timer.cancel();
      } else {
        setState(() {
          _remainingSeconds--;
        });
      }
    });
  }

  void _handleResend() {
    _startCountdown(); // restart timer
    otpController.clear();
  }

  final TextEditingController otpController = TextEditingController();
  final int otpLength = 6;
  final FocusNode _focusNode = FocusNode();

  Future<bool> _verifyOtpRequest(String email, String otp) async {
    showDialog(
      context: context,
      barrierColor: const Color(0x77F5F5F5),
      barrierDismissible: false,
      builder: (_) => const LoadingAnimationWidget(),
    );

    try {
      final response = await http.post(
        Uri.parse(verifyOTP),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'otp': otp}),
      );

      if (mounted) Navigator.of(context).pop(); // Dismiss loading

      final data = jsonDecode(response.body);
      return response.statusCode == 200 && data['message'] == 'OTP verified';
    } catch (e, stack) {
      if (mounted) Navigator.of(context).pop(); // Dismiss loading
      debugPrint('OTP verification error: $e\n$stack');
      return false;
    }
  }

  // Use widget.newUser['email'] instead of newUser['email']
  void _handleOtpConfirm() async {
    final otp = otpController.text.trim();
    final email = newUser['email']; // <-- Use widget.newUser

    if (otp.length != otpLength) {
      _showErrorDialog('Enter a $otpLength-digit OTP');
      return;
    }

    final isValid = await _verifyOtpRequest(email, otp);

    if (!mounted) return;
    if (isValid) {
      context.replace('/signup3');
    } else {
      _showErrorDialog('Invalid OTP. Please try again.');
      print(otpController.text);
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      barrierColor: const Color(0x77F5F5F5),
      builder: (_) => ErrorDialogWidget(error: message),
    );
  }

  //resend otp request
  Future<bool> _sendOtpRequest(BuildContext context) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => LoadingAnimationWidget(),
    );

    try {
      final response = await http.post(
        Uri.parse(requestOTP),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': newUser['email']}),
      );

      Navigator.of(context).pop(); // Dismiss loading

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      Navigator.of(context).pop(); // Dismiss loading
      return false;
    }
  }

  void _handleValidate(BuildContext context) async {
    final success = await _sendOtpRequest(context);

    if (success) {
      _handleResend();
    } else {
      showDialog(
        context: context,
        barrierDismissible: false,
        barrierColor: const Color(0x77F5F5F5),
        builder: (_) =>
            ErrorDialogWidget(error: 'Error, Check your connection'),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final myColors = Theme.of(context).extension<MyColors>()!;
    final isDisabled = _remainingSeconds > 0;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(automaticallyImplyLeading: false),
        body: SafeArea(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        IconButton(
                          onPressed: () {
                            context.pop();
                          },
                          style: ButtonStyle(
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          icon: Icon(Icons.arrow_back_ios_rounded, size: 25),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Let's confirm your email,",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                'A six digit OTP has been sent to the email you provided, confirm by writing it here.',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 100),
                    GestureDetector(
                      onTap: () =>
                          FocusScope.of(context).requestFocus(_focusNode),
                      child: Column(
                        children: [
                          // Invisible TextField for input
                          SizedBox(
                            height: 0,
                            child: Opacity(
                              opacity: 0,
                              child: TextField(
                                controller: otpController,
                                focusNode: _focusNode,
                                keyboardType: TextInputType.number,
                                maxLength: otpLength,
                                onChanged: (_) => setState(() {}),
                                decoration: const InputDecoration(
                                  counterText: '',
                                ), // remove counter
                              ),
                            ),
                          ),

                          // OTP Box Display
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(otpLength, (index) {
                              String digit = '';
                              if (otpController.text.length > index) {
                                digit = otpController.text[index];
                              }

                              return Container(
                                width: MediaQuery.of(context).size.width * 0.12,
                                height:
                                    MediaQuery.of(context).size.width * 0.15,
                                margin: EdgeInsets.symmetric(
                                  horizontal:
                                      MediaQuery.of(context).size.width * 0.01,
                                ),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: myColors.primary,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  digit,
                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              );
                            }),
                          ),
                          TextButton(
                            onPressed: isDisabled
                                ? null
                                : () {
                                    _handleValidate(context);
                                  },
                            child: Text(
                              isDisabled
                                  ? 'Resend in $_remainingSeconds s'
                                  : 'Resend OTP',
                              style: TextStyle(
                                color: isDisabled
                                    ? Colors.grey
                                    : myColors.primary,
                              ),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: _handleOtpConfirm,
                            child: Text('Confirm'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account?',
                      style: TextStyle(fontWeight: FontWeight.w400),
                    ),
                    TextButton(
                      onPressed: () {
                        context.push('/login');
                      },
                      child: Text(
                        'Login',
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
