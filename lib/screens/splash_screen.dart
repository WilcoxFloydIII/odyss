import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:odyss/core/constraints.dart';
import 'package:odyss/core/providers/auth_state_provider.dart';
import 'package:odyss/core/providers/user_list_provider.dart';
import 'package:odyss/data/models/user_model.dart';
import 'package:odyss/screens/loading_animation_widget.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  bool _loadingUser = false;

  Future<void> fetchAndAddUserToProvider(WidgetRef ref) async {
    final accessToken = await secureStorage.read(key: 'access_token');
    if (accessToken == null) return;

    final response = await http.get(
      Uri.parse(usersUrl),
      headers: {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final user = UserModel.fromJson(data);
      print(user.bio);
      print(user.email);
      print(user.firstName);
      print(user.id);
      UID = user.id;
      print(UID);
      print(user.lastName);
      print(user.nickName);
      print(user.number);
      print(user.picture);
      print(user.video);
      print(user.vibes);
      // print(user.rides);
      // Add the user to the user list provider
      ref.read(userListProvider.notifier).addUser(user);
    }
    // Optionally handle errors here
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      await ref.read(authStateProvider.notifier).checkTokenValidity();
      final isAuthenticated = ref.read(authStateProvider);
      await Future.delayed(const Duration(seconds: 2));

      if (isAuthenticated) {
        setState(() => _loadingUser = true);
        await fetchAndAddUserToProvider(ref);
        setState(() => _loadingUser = false);
        context.go('/rides');
      } else {
        context.go('/start');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_loadingUser) {
      return const Scaffold(
        backgroundColor: Colors.white,
        body: Center(child: LoadingAnimationWidget()),
      );
    }
    return Scaffold(
      body: SizedBox.expand(
        child: Image.asset('assets/splash/splash.png', fit: BoxFit.cover),
      ),
    );
  }
}
