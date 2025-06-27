import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:convert';

import 'package:odyss/core/constraints.dart';

final authStateProvider = StateNotifierProvider<AuthStateNotifier, bool>((ref) {
  return AuthStateNotifier(ref);
});

class AuthStateNotifier extends StateNotifier<bool> {
  final Ref ref;

  AuthStateNotifier(this.ref) : super(true);

  Future<void> checkTokenValidity() async {
    final token = await secureStorage.read(key: 'access_token');
    if (token == null || _isTokenExpired(token)) {
      await logout();
    } else {
      state = true;
    }
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
