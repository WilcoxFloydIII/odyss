import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:odyss/core/constraints.dart';
import 'package:odyss/core/providers/list_providers/user_list_provider.dart';
import 'package:odyss/data/models/user_model.dart';
import 'package:odyss/screens/error_dialog_widget.dart';
import 'package:odyss/screens/loading_animation_widget.dart';

class SignupScreen6 extends ConsumerStatefulWidget {
  const SignupScreen6({super.key});

  @override
  ConsumerState<SignupScreen6> createState() => _SignupScreen6State();
}

class _SignupScreen6State extends ConsumerState<SignupScreen6> {
  final TextEditingController inviteLinkController = TextEditingController();
  final TextEditingController accessCodeController = TextEditingController();

  @override
  void dispose() {
    inviteLinkController.dispose();
    accessCodeController.dispose();
    super.dispose();
  }

  Future<void> registerAndLoginUserWithSupabaseMedia({
    required BuildContext context,
    required File profilePic,
    required File introVideo,
    required Map<String, dynamic> newUser,
  }) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: const Color(0x77F5F5F5),
      builder: (_) => const LoadingAnimationWidget(),
    );

    try {
      // Upload image & video to Supabase Storage
      final profilePicUrl = await uploadFileToSupabase(
        profilePic,
        'profile_pics',
      );
      final introVideoUrl = await uploadFileToSupabase(
        introVideo,
        'intro_videos',
      );

      // Prepare full registration payload
      final payload = {
        "first_name": newUser['firstName'],
        "last_name": newUser['lastName'],
        "nickname": newUser['nickname'],
        "email": newUser['email'],
        "password": newUser['password'],
        "bio": newUser['bio'],
        "phone_number": newUser['phone'],
        "profile_pic": profilePicUrl,
        "intro_video": introVideoUrl,
        "date_of_birth": newUser['date_of_birth'],
        "vibes": newUser['vibes'],
        "access_code": newUser['access_code'],
      };

      // Register user
      final registerRes = await http.post(
        Uri.parse('https://server.odyss.ng/auth/register'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(payload),
      );

      if (registerRes.statusCode != 201) {
        final error =
            jsonDecode(registerRes.body)['message'] ?? 'Registration failed';
        throw Exception(error);
      }

      // Login user immediately
      final loginRes = await http.post(
        Uri.parse('https://server.odyss.ng/auth/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "email": newUser['email'],
          "password": newUser['password'],
        }),
      );

      if (loginRes.statusCode == 401) {
        throw Exception('Invalid credentials');
      }

      if (loginRes.statusCode != 200) {
        throw Exception('Login failed');
      }

      final data = jsonDecode(loginRes.body);
      print('Login response data: $data'); // <-- Add this line
      final tokens = data['tokens'];
      final user = data['user'];

      // Save tokens to secure storage
      await secureStorage.write(
        key: 'access_token',
        value: tokens['access_token'],
      );
      await secureStorage.write(
        key: 'refresh_token',
        value: tokens['refresh_token'],
      );
      final token = await secureStorage.read(key: 'access_token');
      print('Saved token: $token');

      // Fetch user data and add to userListProvider
      try {
        final userResponse = await http.get(
          Uri.parse('https://server.odyss.ng/users/me'),
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        );
        if (userResponse.statusCode == 200) {
          final userData = jsonDecode(userResponse.body);
        } else {
          print('Failed to fetch user data: ${userResponse.body}');
        }
      } catch (e) {
        print('Error fetching user data: $e');
      }

      Navigator.pop(context); // Dismiss loading
      context.go('/rides'); // Navigate to rides screen
    } catch (e) {
      Navigator.pop(context);
      showDialog(
        context: context,
        barrierDismissible: false,
        barrierColor: const Color(0x77F5F5F5),
        builder: (_) => ErrorDialogWidget(error: e.toString()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(automaticallyImplyLeading: false),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IconButton(
                        onPressed: () async {
                          context.pop();
                        },
                        style: ButtonStyle(
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        icon: const Icon(
                          Icons.arrow_back_ios_rounded,
                          size: 25,
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'Enter Access Code!',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              "Since we are currently exclusive to a select few you'd need to have an access code to use Odyss",
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
                  const SizedBox(height: 50),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 350,
                    padding: EdgeInsets.all(
                      MediaQuery.of(context).size.width * 0.05,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          padding: EdgeInsets.only(
                            top: 10,
                            bottom: 0,
                            left: 10,
                            right: 10,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(width: 2),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Enter access code'),
                              TextFormField(
                                keyboardType: TextInputType.text,
                                controller: accessCodeController,
                                textInputAction: TextInputAction.next,
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                ),
                                decoration: InputDecoration(
                                  hintText: 'Enter access code here',
                                  hintStyle: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  border: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  contentPadding: EdgeInsets.zero,
                                  disabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          'OR',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w900,
                            color: Colors.grey,
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          padding: EdgeInsets.only(
                            top: 10,
                            bottom: 0,
                            left: 10,
                            right: 10,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(width: 2),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Invite link'),
                              TextFormField(
                                keyboardType: TextInputType.text,
                                controller: inviteLinkController,
                                textInputAction: TextInputAction.next,
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                ),
                                decoration: InputDecoration(
                                  hintText: 'Enter invite link here',
                                  hintStyle: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  border: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  contentPadding: EdgeInsets.zero,
                                  disabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(
                              width: 150,
                              child: ElevatedButton(
                                onPressed: () {
                                  newUser['access_code'] = accessCodeController
                                      .text
                                      .trim();
                                  registerAndLoginUserWithSupabaseMedia(
                                    context: context,
                                    profilePic: File(newUser['picture']),
                                    introVideo: File(newUser['intro_video']),
                                    newUser: newUser,
                                  );
                                },
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Validate',
                                      style: TextStyle(fontSize: 15),
                                    ),
                                    SizedBox(width: 10),
                                    Icon(Icons.arrow_forward_rounded, size: 20),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Already have an account?',
                    style: TextStyle(fontWeight: FontWeight.w400),
                  ),
                  TextButton(
                    onPressed: () => context.push('/login'),
                    child: const Text(
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
    );
  }
}
