// import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// class TokenStore {
//   static const _key = 'pmgt_token';
//   final FlutterSecureStorage _storage = const FlutterSecureStorage();

//   Future<void> saveToken(String token) => _storage.write(key: _key, value: token);
//   Future<String?> readToken() => _storage.read(key: _key);
//   Future<void> clear() => _storage.delete(key: _key);
// }


import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Lightweight wrapper over secure storage so we can swap/testing later.
class TokenStore {
  TokenStore() : _storage = const FlutterSecureStorage();

  final FlutterSecureStorage _storage;

  static const _key = 'pmgt_jwt';

  Future<void> save(String token) => _storage.write(key: _key, value: token);

  Future<String?> read() => _storage.read(key: _key);

  Future<void> clear() => _storage.delete(key: _key);
}
