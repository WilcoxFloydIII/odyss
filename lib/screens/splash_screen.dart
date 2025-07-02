import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:odyss/core/constraints.dart';
import 'package:odyss/core/providers/other_providers/auth_state_provider.dart';
import 'package:odyss/data/models/user_model.dart';
import 'package:odyss/screens/loading_animation_widget.dart';
import 'package:odyss/screens/error_dialog_widget.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  // ignore: unused_field
  bool _loadingUser = false;
  String? _errorMessage;
  Timer? _refreshTimer;

  Future<void> fetchAndAddUserToProvider(WidgetRef ref) async {
    final accessToken = await secureStorage.read(key: 'access_token');
    if (accessToken == null) {
      setState(() => _errorMessage = 'No access token found.');
      return;
    }

    try {
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
        UID = user.id;
      } else {
        setState(
          () => _errorMessage = 'Failed to fetch user info: ${response.body}',
        );
      }
    } catch (e) {
      setState(() => _errorMessage = 'Error fetching user info: $e');
    }
  }

  Future<void> refreshAccessToken() async {
    final refreshToken = await secureStorage.read(key: 'refresh_token');
    if (refreshToken == null) return;

    final response = await http.post(
      Uri.parse('https://server.odyss.ng/auth/token/refresh'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'refresh_token': refreshToken}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final newAccessToken = data['access_token'];
      if (newAccessToken != null) {
        await secureStorage.write(key: 'access_token', value: newAccessToken);
        print('Access token refreshed!');
      }
    } else {
      print('Failed to refresh access token: ${response.body}');
    }
  }

  void _showLoadingDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.white.withOpacity(0.7),
      builder: (_) => const LoadingAnimationWidget(),
    );
  }

  void _hideDialog() {
    if (Navigator.of(context, rootNavigator: true).canPop()) {
      Navigator.of(context, rootNavigator: true).pop();
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => ErrorDialogWidget(
        error: message,
        onRetry: () {
          _hideDialog();
          _retryLoad(ref);
        },
      ),
    );
  }

  Future<void> _retryLoad(WidgetRef ref) async {
    _showLoadingDialog();
    await fetchAndAddUserToProvider(ref);
    if (_errorMessage != null) {
      _hideDialog();
      _showErrorDialog(_errorMessage!);
      return;
    }
    _hideDialog();
    if (_errorMessage == null) {
      context.go('/rides');
    } else {
      _showErrorDialog(_errorMessage!);
    }
  }

  @override
  void initState() {
    super.initState();

    // Keep the refresh token timer
    _refreshTimer = Timer.periodic(const Duration(minutes: 40), (_) {
      refreshAccessToken();
    });

    Future.microtask(() async {
      await Future.delayed(const Duration(seconds: 3));
      _showLoadingDialog();
      // Wait for 3 seconds before starting authentication and data fetch
      await ref.read(authStateProvider.notifier).checkTokenValidity();
      final isAuthenticated = ref.read(authStateProvider);
      await Future.delayed(const Duration(seconds: 2));

      if (isAuthenticated) {
        await fetchAndAddUserToProvider(ref);
        if (_errorMessage != null) {
          _hideDialog();
          _showErrorDialog(_errorMessage!);
          return;
        }
        if (_errorMessage == null) {
          context.go('/rides');
        } else {
          _showErrorDialog(_errorMessage!);
        }
      } else {
        _hideDialog();
        context.go('/start');
      }
    });
  }

  @override
  void dispose() {
    _refreshTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Always show splash image, dialogs will overlay
    return Scaffold(
      body: SizedBox.expand(
        child: Image.asset('assets/splash/splash.png', fit: BoxFit.cover),
      ),
    );
  }
}
