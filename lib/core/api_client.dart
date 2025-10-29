import 'dart:convert';
import 'package:http/http.dart' as http;

import 'env.dart';
import 'token_store.dart';

typedef UnauthorizedHandler = Future<void> Function();

/// Minimal API client that automatically attaches the bearer token (if any)
/// and calls a global 401 handler.
class ApiClient {
  ApiClient(this._tokenStore, {UnauthorizedHandler? onUnauthorized})
      : _onUnauthorized = onUnauthorized;

  final TokenStore _tokenStore;
  final UnauthorizedHandler? _onUnauthorized;

  Uri _u(String path, [Map<String, dynamic>? q]) =>
      Uri.parse('${Env.apiBase}$path').replace(queryParameters: q);

  Future<http.Response> get(String path, {Map<String, String>? headers}) async {
    final token = await _tokenStore.read();
    final res = await http.get(
      _u(path),
      headers: {
        'Accept': 'application/json',
        if (token != null && token.isNotEmpty) 'Authorization': 'Bearer $token',
        ...?headers,
      },
    );
    if (res.statusCode == 401 && _onUnauthorized != null) {
      await _onUnauthorized.call();
    }
    return res;
  }

  Future<http.Response> post(
    String path, {
    Map<String, String>? headers,
    Map<String, dynamic>? body,
  }) async {
    final token = await _tokenStore.read();
    final res = await http.post(
      _u(path),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        if (token != null && token.isNotEmpty) 'Authorization': 'Bearer $token',
        ...?headers,
      },
      body: body == null ? null : jsonEncode(body),
    );
    if (res.statusCode == 401 && _onUnauthorized != null) {
      await _onUnauthorized.call();
    }
    return res;
  }
}
