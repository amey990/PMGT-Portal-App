// import 'dart:convert';
// import 'package:flutter/foundation.dart';
// import 'package:jwt_decoder/jwt_decoder.dart';

// import '../core/api_client.dart';
// import '../core/token_store.dart';

// class UserSession extends ChangeNotifier {
//   final TokenStore _store;
//   final ApiClient _api;

//   UserSession(this._store, this._api);

//   String? _token;
//   String? _email;
//   String? _role;

//   String? get token => _token;
//   String? get email => _email;
//   String? get role => _role;
//   bool get isAuthenticated => _token != null && _token!.isNotEmpty;

//   /// Restore from secure storage and decode.
//   Future<void> restore() async {
//     final t = await _store.readToken();
//     if (t == null || t.isEmpty || JwtDecoder.isExpired(t)) {
//       await _store.clear();
//       _token = _email = _role = null;
//       notifyListeners();
//       return;
//     }
//     _token = t;
//     try {
//       final payload = JwtDecoder.decode(t);
//       _email = payload['email'] as String?;
//       _role  = payload['role'] as String?;
//     } catch (_) {
//       _email = _role = null;
//     }
//     notifyListeners();
//   }

//   /// After successful login
//   Future<void> setAuthenticated({
//     required String token,
//     required String email,
//     required String role,
//   }) async {
//     _token = token;
//     _email = email;
//     _role  = role;
//     await _store.saveToken(token);
//     notifyListeners();
//   }

//   /// Sign out
//   Future<void> signOut() async {
//     _token = null;
//     _email = null;
//     _role  = null;
//     await _store.clear();
//     notifyListeners();
//   }
// }


import 'package:flutter/foundation.dart';
import '../core/token_store.dart';
import '../core/api_client.dart';

/// Small app-level session holder (email/role mainly for convenience).
class UserSession extends ChangeNotifier {
  UserSession(this._tokenStore, this._api);

  final TokenStore _tokenStore;
  final ApiClient _api;

  String? _token;
  String? _email;
  String? _role;

  String? get token => _token;
  String? get email => _email;
  String? get role  => _role;

  bool get isAuthenticated => _token != null && _token!.isNotEmpty;

  /// Restore existing token from secure storage (if any).
  Future<void> restore() async {
    _token = await _tokenStore.read();
    // If you want, you can fetch / decode user info here using _api.
    notifyListeners();
  }

  /// Save new session after login.
  Future<void> setAuthenticated({
    required String token,
    required String email,
    required String role,
  }) async {
    _token = token;
    _email = email;
    _role = role;
    await _tokenStore.save(token);
    notifyListeners();
  }

  /// Sign out and wipe local state.
  Future<void> signOut() async {
    _token = null;
    _email = null;
    _role = null;
    await _tokenStore.clear();
    notifyListeners();
  }
}
