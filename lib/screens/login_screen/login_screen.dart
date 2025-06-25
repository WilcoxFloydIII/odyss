import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:odyss/core/colors.dart';
import 'package:odyss/core/constraints.dart';
import 'package:odyss/core/providers/user_list_provider.dart';
import 'package:odyss/data/models/user_model.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _SignupScreen2State();
}

class _SignupScreen2State extends ConsumerState<LoginScreen> {
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
                                      if (users.any(
                                        (user) =>
                                            user.email == emailController.text,
                                      )) {
                                        UserModel validatedUser = users
                                            .firstWhere(
                                              (user) =>
                                                  user.email ==
                                                  emailController.text,
                                            );

                                        if (validatedUser.password ==
                                            passwordController.text) {
                                          UID = validatedUser.id;
                                          context.go('/rides');
                                        } else {
                                          Flushbar(
                                            message:
                                                'Invalid username or password',
                                            duration: Duration(seconds: 2),
                                            flushbarPosition: FlushbarPosition
                                                .TOP, // Top of screen
                                            backgroundColor: Colors
                                                .red, // Optional: customize color
                                            margin: EdgeInsets.all(
                                              8,
                                            ), // Optional: margin for better look
                                            borderRadius: BorderRadius.circular(
                                              8,
                                            ), // Optional: rounded corners
                                          ).show(context);
                                        }
                                      } else {
                                        Flushbar(
                                          message:
                                              'Invalid username or password',
                                          duration: Duration(seconds: 2),
                                          flushbarPosition: FlushbarPosition
                                              .TOP, // Top of screen
                                          backgroundColor: Colors
                                              .red, // Optional: customize color
                                          margin: EdgeInsets.all(
                                            8,
                                          ), // Optional: margin for better look
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ), // Optional: rounded corners
                                        ).show(context);
                                      }
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
