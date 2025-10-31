// lib/services/auth_service.dart
import 'dart:convert';
import '../core/api_client.dart';

class AuthService {
  AuthService(this._api);
  final ApiClient _api;

  // ---------- LOGIN ----------
  /// Returns a Dart 3 record: ({ token, user })
  Future<({String token, Map<String, dynamic> user})> login({
    required String email,
    required String password,
  }) async {
    final r = await _api.post('/api/auth/login', body: {
      'email': email,
      'password': password,
    });

    Map<String, dynamic> data = {};
    try {
      data = (jsonDecode(r.body) as Map).cast<String, dynamic>();
    } catch (_) {}

    if (r.statusCode < 200 || r.statusCode >= 300) {
      final msg = (data['error'] ?? 'Login failed (${r.statusCode})').toString();
      throw Exception(msg);
    }

    final String? token = (data['token'] ?? data['access_token']) as String?;
    final Map<String, dynamic> user =
        (data['user'] as Map?)?.cast<String, dynamic>() ?? {};

    if (token == null || token.isEmpty) {
      throw Exception('Invalid login response (no token)');
    }

    return (token: token, user: user);
  }

  // ---------- SIGNUP (User) ----------
  Future<void> signupUser({
    required String username,
    required String email,
    required String password,
    required String role,
  }) async {
    final r = await _api.post('/api/auth/signup/user', body: {
      'username': username,
      'email': email,
      'password': password,
      'role': role,
    });

    Map<String, dynamic> data = {};
    try {
      data = (jsonDecode(r.body) as Map).cast<String, dynamic>();
    } catch (_) {}

    if (r.statusCode == 409) {
      throw Exception('User already exists');
    }
    if (r.statusCode < 200 || r.statusCode >= 300) {
      throw Exception((data['error'] ?? 'Signup failed').toString());
    }
  }

  // ---------- FORGOT / SEND CODE ----------
  /// Sends an OTP to the given email. Web route: POST /api/auth/forgot
  Future<void> sendResetCode({required String email}) async {
    final r = await _api.post('/api/auth/forgot', body: {
      'email': email,
    });

    Map<String, dynamic> data = {};
    try {
      data = (jsonDecode(r.body) as Map).cast<String, dynamic>();
    } catch (_) {}

    if (r.statusCode == 404) {
      throw Exception('User not registered');
    }
    if (r.statusCode < 200 || r.statusCode >= 300) {
      throw Exception((data['error'] ?? 'Could not send code').toString());
    }
  }

  // ---------- RESET PASSWORD ----------
  /// Resets the password using the OTP. Web route: POST /api/auth/reset
  Future<void> resetPassword({
    required String email,
    required String otpCode,
    required String newPassword,
  }) async {
    final r = await _api.post('/api/auth/reset', body: {
      'email': email,
      'otp_code': otpCode,
      'password': newPassword,
    });

    Map<String, dynamic> data = {};
    try {
      data = (jsonDecode(r.body) as Map).cast<String, dynamic>();
    } catch (_) {}

    if (r.statusCode == 400) {
      // typical for invalid/expired OTP
      throw Exception((data['error'] ?? 'Invalid or expired code').toString());
    }
    if (r.statusCode < 200 || r.statusCode >= 300) {
      throw Exception((data['error'] ?? 'Reset failed').toString());
    }
  }
}
