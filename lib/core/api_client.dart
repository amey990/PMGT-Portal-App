// import 'dart:convert';
// import 'package:http/http.dart' as http;

// import 'env.dart';
// import 'token_store.dart';

// typedef UnauthorizedHandler = Future<void> Function();

// /// Minimal API client that automatically attaches the bearer token (if any)
// /// and calls a global 401 handler.
// class ApiClient {
//   ApiClient(this._tokenStore, {UnauthorizedHandler? onUnauthorized})
//       : _onUnauthorized = onUnauthorized;

//   final TokenStore _tokenStore;
//   final UnauthorizedHandler? _onUnauthorized;

//   // 👉 NEW: expose base url so UI can compose absolute URLs if needed
//   String get baseUrl => Env.apiBase;

//   // 👉 NEW: async token accessor
//   Future<String?> getToken() => _tokenStore.read();

//   Uri _u(String path, [Map<String, dynamic>? q]) =>
//       Uri.parse('${Env.apiBase}$path').replace(queryParameters: q);

//   Future<http.Response> get(String path, {Map<String, String>? headers}) async {
//     final token = await _tokenStore.read();
//     final res = await http.get(
//       _u(path),
//       headers: {
//         'Accept': 'application/json',
//         if (token != null && token.isNotEmpty) 'Authorization': 'Bearer $token',
//         ...?headers,
//       },
//     );
//     if (res.statusCode == 401 && _onUnauthorized != null) {
//       await _onUnauthorized.call();
//     }
//     return res;
//   }

//   Future<http.Response> post(
//     String path, {
//     Map<String, String>? headers,
//     Map<String, dynamic>? body,
//   }) async {
//     final token = await _tokenStore.read();
//     final res = await http.post(
//       _u(path),
//       headers: {
//         'Accept': 'application/json',
//         'Content-Type': 'application/json',
//         if (token != null && token.isNotEmpty) 'Authorization': 'Bearer $token',
//         ...?headers,
//       },
//       body: body == null ? null : jsonEncode(body),
//     );
//     if (res.statusCode == 401 && _onUnauthorized != null) {
//       await _onUnauthorized.call();
//     }
//     return res;
//   }

//   // 👉 NEW: PUT used by “Update Site”
//   Future<http.Response> put(
//     String path, {
//     Map<String, String>? headers,
//     Map<String, dynamic>? body,
//   }) async {
//     final token = await _tokenStore.read();
//     final res = await http.put(
//       _u(path),
//       headers: {
//         'Accept': 'application/json',
//         'Content-Type': 'application/json',
//         if (token != null && token.isNotEmpty) 'Authorization': 'Bearer $token',
//         ...?headers,
//       },
//       body: body == null ? null : jsonEncode(body),
//     );
//     if (res.statusCode == 401 && _onUnauthorized != null) {
//       await _onUnauthorized.call();
//     }
//     return res;
//   }
// }


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

  /// Expose base url so UI can compose absolute URLs if needed
  String get baseUrl => Env.apiBase;

  /// Async token accessor (reflects whatever is in secure storage)
  Future<String?> getToken() => _tokenStore.readToken();

  Uri _u(String path, [Map<String, dynamic>? q]) =>
      Uri.parse('${Env.apiBase}$path').replace(queryParameters: q);

  Future<Map<String, String>> _headers(Map<String, String>? extra) async {
    final token = await _tokenStore.readToken();
    return {
      'Accept': 'application/json',
      if (token != null && token.isNotEmpty) 'Authorization': 'Bearer $token',
      ...?extra,
    };
  }

  Future<void> _handle401(int statusCode) async {
    if (statusCode == 401 && _onUnauthorized != null) {
      await _onUnauthorized!.call();
    }
  }

  // ─────────────────────────── HTTP JSON helpers ───────────────────────────

  Future<http.Response> get(
    String path, {
      Map<String, String>? headers,
      Map<String, dynamic>? query,
    }) async {
    final res = await http.get(_u(path, query), headers: await _headers(headers));
    await _handle401(res.statusCode);
    return res;
  }

  Future<http.Response> post(
    String path, {
      Map<String, String>? headers,
      Map<String, dynamic>? body,
      Map<String, dynamic>? query,
    }) async {
    final res = await http.post(
      _u(path, query),
      headers: await _headers({
        'Content-Type': 'application/json',
        ...?headers,
      }),
      body: body == null ? null : jsonEncode(body),
    );
    await _handle401(res.statusCode);
    return res;
  }

  /// Used by “Update Site”, etc.
  Future<http.Response> put(
    String path, {
      Map<String, String>? headers,
      Map<String, dynamic>? body,
      Map<String, dynamic>? query,
    }) async {
    final res = await http.put(
      _u(path, query),
      headers: await _headers({
        'Content-Type': 'application/json',
        ...?headers,
      }),
      body: body == null ? null : jsonEncode(body),
    );
    await _handle401(res.statusCode);
    return res;
  }

  Future<http.Response> delete(
    String path, {
      Map<String, String>? headers,
      Map<String, dynamic>? query,
    }) async {
    final res = await http.delete(
      _u(path, query),
      headers: await _headers(headers),
    );
    await _handle401(res.statusCode);
    return res;
  }

  /// Raw bytes (e.g., CSV export)
  Future<http.Response> getBytes(
    String path, {
      Map<String, dynamic>? query,
      Map<String, String>? headers,
    }) async {
    final res = await http.get(
      _u(path, query),
      headers: await _headers({
        // do NOT set Content-Type for bytes
        ...?headers,
      }),
    );
    await _handle401(res.statusCode);
    return res;
  }

  // ─────────────────────────── Multipart helper ───────────────────────────
  /// For endpoints expecting multipart/form-data (e.g., profile picture).
  /// `method` can be 'POST' or 'PUT'.
  Future<http.StreamedResponse> multipart(
    String path, {
      String method = 'POST',
      Map<String, String>? fields,
      List<http.MultipartFile>? files,
      Map<String, dynamic>? query,
      Map<String, String>? headers,
    }) async {
    final uri = _u(path, query);
    final req = http.MultipartRequest(method, uri);

    // Auth + any extras (do NOT force JSON headers here)
    req.headers.addAll(await _headers(headers));

    if (fields != null) req.fields.addAll(fields);
    if (files != null) req.files.addAll(files);

    final streamed = await req.send();
    await _handle401(streamed.statusCode);
    return streamed;
  }
}
