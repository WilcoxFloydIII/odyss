import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:odyss/core/constraints.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Delay for 2 seconds (or until init tasks complete)
    Future.delayed(const Duration(seconds: 3), () {
      context.go(initLocationFunc());
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Image.asset('assets/splash/splash.png', fit: BoxFit.cover),
      ),
    );
  }
}
