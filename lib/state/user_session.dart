// import 'package:flutter/foundation.dart';
// import '../core/token_store.dart';
// import '../core/api_client.dart';


// class UserSession extends ChangeNotifier {
//   UserSession(this._tokenStore, this._api);

//   final TokenStore _tokenStore;
//   final ApiClient _api; // (not used directly here)

//   String? _token;
//   String? _email;
//   String? _role;

//   String? get token => _token;
//   String? get email => _email;
//   String? get role  => _role;

//   bool get isAuthenticated => (_token ?? '').isNotEmpty;

//   /// Restore existing values from secure storage (call on app start).
//   Future<void> restore() async {
//     _token = await _tokenStore.readToken();
//     _email = await _tokenStore.readEmail();
//     _role  = await _tokenStore.readRole();
//     notifyListeners();
//   }

//   /// Save new session after login.
//   Future<void> setAuthenticated({
//     required String token,
//     required String email,
//     required String role,
//   }) async {
//     _token = token;
//     _email = email;
//     _role  = role;

//     await _tokenStore.saveAll(token: token, email: email, role: role);
//     notifyListeners();
//   }

//   /// Optional helper if the email ever changes.
//   Future<void> updateEmail(String email) async {
//     _email = email;
//     await _tokenStore.saveEmail(email);
//     notifyListeners();
//   }

//   /// Sign out and wipe local state.
//   Future<void> signOut() async {
//     _token = null;
//     _email = null;
//     _role  = null;
//     await _tokenStore.clearAll();
//     notifyListeners();
//   }
// }

import 'dart:convert';
import 'package:flutter/foundation.dart';
import '../core/token_store.dart';
import '../core/api_client.dart';

/// App-level session holder (JWT/email/role/avatar) + persistence + hydration.
class UserSession extends ChangeNotifier {
  UserSession(this._tokenStore, this._api);

  final TokenStore _tokenStore;
  final ApiClient _api;

  String? _token;
  String? _email;
  String? _role;
  String? _avatarUrl;

  String? get token => _token;
  String? get email => _email;
  String? get role  => _role;
  String? get avatarUrl => _avatarUrl;

  bool get isAuthenticated => (_token ?? '').isNotEmpty;

  /// Restore existing values from secure storage (call on app start).
  Future<void> restore() async {
    _token     = await _tokenStore.readToken();
    _email     = await _tokenStore.readEmail();
    _role      = await _tokenStore.readRole();
    _avatarUrl = await _tokenStore.readAvatarUrl();
    notifyListeners();

    // Hydrate avatar from server (web-like behavior)
    if ((_token ?? '').isNotEmpty && (_email ?? '').isNotEmpty) {
      await _hydrateAvatarFromServer();
    }
  }

  Future<void> _hydrateAvatarFromServer() async {
    try {
      final res = await _api.get('/api/user-profile/${Uri.encodeComponent(_email!)}');
      if (res.statusCode >= 200 && res.statusCode < 300) {
        final data = jsonDecode(res.body) as Map<String, dynamic>;
        final pic = (data['user_profile']?['profile_picture'] ?? '').toString();
        final url = pic.isNotEmpty ? (_api.baseUrl + pic) : null;
        _avatarUrl = url;
        await _tokenStore.saveAvatarUrl(url);
        notifyListeners();
      } else if (res.statusCode == 404) {
        _avatarUrl = null;
        await _tokenStore.saveAvatarUrl(null);
        notifyListeners();
      }
    } catch (_) {
      // ignore network errors
    }
  }

  /// Save new session after login.
  Future<void> setAuthenticated({
    required String token,
    required String email,
    required String role,
    String? avatarUrl,
  }) async {
    _token = token;
    _email = email;
    _role  = role;
    _avatarUrl = avatarUrl;

    await _tokenStore.saveAll(
      token: token,
      email: email,
      role: role,
      avatarUrl: avatarUrl,
    );
    notifyListeners();

    // In case avatarUrl wasn't supplied on login, fetch it
    await _hydrateAvatarFromServer();
  }

  /// Optional helper if the email ever changes.
  Future<void> updateEmail(String email) async {
    _email = email;
    await _tokenStore.saveEmail(email);
    notifyListeners();
    await _hydrateAvatarFromServer();
  }

  /// Public setter to update avatar everywhere (e.g., after profile save).
  Future<void> setAvatarUrl(String? url) async {
    _avatarUrl = url;
    await _tokenStore.saveAvatarUrl(url);
    notifyListeners();
  }

  /// Sign out and wipe local state.
  Future<void> signOut() async {
    _token = null;
    _email = null;
    _role  = null;
    _avatarUrl = null;
    await _tokenStore.clearAll();
    notifyListeners();
  }
}
