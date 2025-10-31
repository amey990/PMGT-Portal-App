import 'package:flutter/foundation.dart';
import '../core/token_store.dart';
import '../core/api_client.dart';


class UserSession extends ChangeNotifier {
  UserSession(this._tokenStore, this._api);

  final TokenStore _tokenStore;
  final ApiClient _api; // (not used directly here)

  String? _token;
  String? _email;
  String? _role;

  String? get token => _token;
  String? get email => _email;
  String? get role  => _role;

  bool get isAuthenticated => (_token ?? '').isNotEmpty;

  /// Restore existing values from secure storage (call on app start).
  Future<void> restore() async {
    _token = await _tokenStore.readToken();
    _email = await _tokenStore.readEmail();
    _role  = await _tokenStore.readRole();
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
    _role  = role;

    await _tokenStore.saveAll(token: token, email: email, role: role);
    notifyListeners();
  }

  /// Optional helper if the email ever changes.
  Future<void> updateEmail(String email) async {
    _email = email;
    await _tokenStore.saveEmail(email);
    notifyListeners();
  }

  /// Sign out and wipe local state.
  Future<void> signOut() async {
    _token = null;
    _email = null;
    _role  = null;
    await _tokenStore.clearAll();
    notifyListeners();
  }
}
