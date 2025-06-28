import 'dart:async';
import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:odyss/core/constraints.dart';

final authStateProvider = StateNotifierProvider<AuthStateNotifier, bool>((ref) {
  return AuthStateNotifier(ref);
});

class AuthStateNotifier extends StateNotifier<bool> {
  final Ref ref;
  Timer? _refreshTimer;

  AuthStateNotifier(this.ref) : super(true) {
    _startPeriodicRefresh();
  }

  Future<void> checkTokenValidity() async {
    final refreshToken = await secureStorage.read(key: 'refresh_token');
    final accessToken = await secureStorage.read(key: 'access_token');
    print('Refresh token: $refreshToken');
    print('Access token: $accessToken');

    if (refreshToken == null ||
        accessToken == null ||
        _isTokenExpired(refreshToken)) {
      print('Token missing or expired');
      await logout();
      return;
    }

    final success = await _refreshAccessToken(accessToken, refreshToken);
    print('Refresh access token success: $success');
    if (!success) {
      print('Failed to refresh access token');
      await logout();
      return;
    }

    state = true;
  }

  Future<bool> _refreshAccessToken(
    String accessToken,
    String refreshToken,
  ) async {
    final response = await http.post(
      Uri.parse('https://server.odyss.ng/auth/token/refresh'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $refreshToken',
      }
      //body: jsonEncode({'refresh_token': refreshToken}),
    );
    print('Refresh response: ${response.statusCode} ${response.body}');
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final newAccessToken = data['access_token'];
      print('New access token: $newAccessToken');
      if (newAccessToken != null) {
        await secureStorage.write(key: 'access_token', value: newAccessToken);
        return true;
      }
    }
    return false;
  }

  void _startPeriodicRefresh() async {
    // Cancel any existing timer
    _refreshTimer?.cancel();

    // Start a new timer that refreshes the access token every 40 minutes
    _refreshTimer = Timer.periodic(const Duration(minutes: 40), (_) async {
      final refreshToken = await secureStorage.read(key: 'refresh_token');
      final accessToken = await secureStorage.read(key: 'access_token');
      if (refreshToken != null &&
          accessToken != null &&
          !_isTokenExpired(refreshToken)) {
        await _refreshAccessToken(accessToken, refreshToken);
      }
    });
  }

  @override
  void dispose() {
    _refreshTimer?.cancel();
    super.dispose();
  }

  bool _isTokenExpired(String token) {
    try {
      final parts = token.split('.');
      if (parts.length != 3) return true;
      final payload = jsonDecode(
        utf8.decode(base64Url.decode(base64Url.normalize(parts[1]))),
      );
      final expiry = payload['exp'] as int;
      final now = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      return expiry < now;
    } catch (_) {
      return true;
    }
  }

  Future<void> logout() async {
    state = false;

    // Clear secure storage
    await secureStorage.delete(key: 'access_token');
    await secureStorage.delete(key: 'refresh_token');

    // Clear shared preferences
    final prefs = await getSharedPrefs();
    await prefs.clear();
  }
}
