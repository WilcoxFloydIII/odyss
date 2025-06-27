import 'dart:convert';
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:odyss/core/colors.dart';
import 'package:odyss/core/constraints.dart';
import 'package:odyss/core/providers/user_list_provider.dart';
import 'package:odyss/data/models/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:odyss/screens/loading_animation_widget.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    List<UserModel> users = ref.watch(userListProvider);

    final myColors = Theme.of(context).extension<MyColors>()!;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
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
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IconButton(
                          onPressed: () {
                            context.pop();
                          },
                          icon: Icon(Icons.arrow_back_ios_rounded, size: 30),
                        ),
                        Text(
                          'Welcome back,',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 50),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 350,
                      padding: EdgeInsets.all(
                        MediaQuery.sizeOf(context).width * 0.05,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                              border: Border.all(
                                width: 2,
                                color: myColors.primary,
                              ),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Email'),
                                TextFormField(
                                  keyboardType: TextInputType.emailAddress,
                                  controller: emailController,
                                  textInputAction: TextInputAction.next,
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  decoration: InputDecoration(
                                    hintText: 'Input email',
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
                          Container(
                            width: MediaQuery.of(context).size.width * 0.9,
                            padding: EdgeInsets.only(
                              top: 10,
                              bottom: 0,
                              left: 10,
                              right: 10,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 2,
                                color: myColors.primary,
                              ),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Password'),
                                TextFormField(
                                  obscureText: true,
                                  obscuringCharacter: '●',
                                  inputFormatters: [
                                    // Only allow letters, numbers, and common symbols
                                    FilteringTextInputFormatter.allow(
                                      RegExp(
                                        r'[A-Za-z0-9!@#\$%^&*()_\-+=\[\]{}|;:,.<>?/~`]',
                                      ),
                                    ),
                                    FilteringTextInputFormatter.deny(
                                      RegExp(r'[ ]'),
                                    ), // Disallow spaces
                                  ],
                                  enableSuggestions: false,
                                  keyboardType: TextInputType.visiblePassword,
                                  controller: passwordController,
                                  textInputAction: TextInputAction.next,
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  decoration: InputDecoration(
                                    hintText: 'Input password',
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
                              Container(
                                width: 130,
                                child: ElevatedButton(
                                  onPressed: () {
                                    if (emailController.text.isEmpty) {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(
                                          duration: Duration(seconds: 2),
                                          backgroundColor: myColors.backgound,
                                          content: Text(
                                            'Email must be provided',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Colors.red,
                                              fontSize: 13,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      );
                                    } else if (passwordController
                                        .text
                                        .isEmpty) {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(
                                          duration: Duration(seconds: 2),
                                          backgroundColor: myColors.backgound,
                                          content: Text(
                                            'Password must be provided',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Colors.red,
                                              fontSize: 13,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      );
                                    } else {
                                      loginAndFetchUser(context, ref);
                                    }
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Login',
                                        style: TextStyle(fontSize: 15),
                                      ),
                                      SizedBox(width: 10),
                                      Icon(
                                        Icons.arrow_forward_rounded,
                                        size: 20,
                                      ),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Future<void> loginAndFetchUser(BuildContext context, WidgetRef ref) async {
  showDialog(
    context: context,
    barrierDismissible: false,
    barrierColor: const Color(0x77F5F5F5),
    builder: (_) => const LoadingAnimationWidget(),
  );

  try {
    // Login user
    final loginRes = await http.post(
      Uri.parse('https://server.odyss.ng/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "email": (context as StatefulElement).state is _LoginScreenState
            ? ((context).state as _LoginScreenState).emailController.text.trim()
            : "",
        "password": (context).state is _LoginScreenState
            ? ((context).state as _LoginScreenState).passwordController.text
                  .trim()
            : "",
      }),
    );

    if (loginRes.statusCode == 401) {
      throw Exception('Invalid credentials');
    }
    if (loginRes.statusCode != 200) {
      throw Exception('Login failed');
    }

    final data = jsonDecode(loginRes.body);
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
        final userModel = UserModel.fromJson(userData);
        ref.read(userListProvider.notifier).addUser(userModel);

        UID = userModel.id; // Store UID globally
        print('User ID: $UID');
        print('User Email: ${userModel.email}');
        print('User Name: ${userModel.firstName} ${userModel.lastName}');
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
      builder: (_) => AlertDialog(
        title: const Text('Login Error'),
        content: Text(e.toString()),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
