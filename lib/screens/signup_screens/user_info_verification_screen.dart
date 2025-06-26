import 'package:flutter/material.dart';

class UserInfoVerificationScreen extends StatefulWidget {
  const UserInfoVerificationScreen({super.key});

  @override
  State<UserInfoVerificationScreen> createState() => _UserInfoVerificationScreenState();
}

class _UserInfoVerificationScreenState extends State<UserInfoVerificationScreen> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(),
    );
  }
}