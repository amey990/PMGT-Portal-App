// import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// class TokenStore {
//   TokenStore() : _storage = const FlutterSecureStorage();

//   final FlutterSecureStorage _storage;

//   static const _jwtKey   = 'pmgt_jwt';
//   static const _emailKey = 'pmgt_email';
//   static const _roleKey  = 'pmgt_role';

//   // ---------- Token ----------
//   Future<void> saveToken(String token) => _storage.write(key: _jwtKey, value: token);
//   Future<String?> readToken() => _storage.read(key: _jwtKey);
//   Future<void> clearToken() => _storage.delete(key: _jwtKey);

//   // ---------- Email ----------
//   Future<void> saveEmail(String email) => _storage.write(key: _emailKey, value: email);
//   Future<String?> readEmail() => _storage.read(key: _emailKey);
//   Future<void> clearEmail() => _storage.delete(key: _emailKey);

//   // ---------- Role ----------
//   Future<void> saveRole(String role) => _storage.write(key: _roleKey, value: role);
//   Future<String?> readRole() => _storage.read(key: _roleKey);
//   Future<void> clearRole() => _storage.delete(key: _roleKey);

//   // ---------- Helpers ----------
//   Future<void> saveAll({required String token, String? email, String? role}) async {
//     await saveToken(token);
//     if (email != null) await saveEmail(email);
//     if (role  != null) await saveRole(role);
//   }

//   Future<void> clearAll() async {
//     await Future.wait([clearToken(), clearEmail(), clearRole()]);
//   }
// }


import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenStore {
  TokenStore() : _storage = const FlutterSecureStorage();

  final FlutterSecureStorage _storage;

  static const _jwtKey    = 'pmgt_jwt';
  static const _emailKey  = 'pmgt_email';
  static const _roleKey   = 'pmgt_role';
  static const _avatarKey = 'pmgt_avatar';

  // ---------- Token ----------
  Future<void> saveToken(String token) => _storage.write(key: _jwtKey, value: token);
  Future<String?> readToken() => _storage.read(key: _jwtKey);
  Future<void> clearToken() => _storage.delete(key: _jwtKey);

  // ---------- Email ----------
  Future<void> saveEmail(String email) => _storage.write(key: _emailKey, value: email);
  Future<String?> readEmail() => _storage.read(key: _emailKey);
  Future<void> clearEmail() => _storage.delete(key: _emailKey);

  // ---------- Role ----------
  Future<void> saveRole(String role) => _storage.write(key: _roleKey, value: role);
  Future<String?> readRole() => _storage.read(key: _roleKey);
  Future<void> clearRole() => _storage.delete(key: _roleKey);

  // ---------- Avatar ----------
  Future<void> saveAvatarUrl(String? url) =>
      url == null ? _storage.delete(key: _avatarKey)
                  : _storage.write(key: _avatarKey, value: url);
  Future<String?> readAvatarUrl() => _storage.read(key: _avatarKey);
  Future<void> clearAvatarUrl() => _storage.delete(key: _avatarKey);

  // ---------- Helpers ----------
  Future<void> saveAll({
    required String token,
    String? email,
    String? role,
    String? avatarUrl,
  }) async {
    await saveToken(token);
    if (email != null) await saveEmail(email);
    if (role  != null) await saveRole(role);
    await saveAvatarUrl(avatarUrl);
  }

  Future<void> clearAll() async {
    await Future.wait([
      clearToken(),
      clearEmail(),
      clearRole(),
      clearAvatarUrl(),
    ]);
  }
}
