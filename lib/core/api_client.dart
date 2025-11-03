// import 'dart:convert';
// import 'package:http/http.dart' as http;

// import 'env.dart';
// import 'token_store.dart';

// typedef UnauthorizedHandler = Future<void> Function();

// class ApiClient {
//   ApiClient(this._tokenStore, {UnauthorizedHandler? onUnauthorized})
//       : _onUnauthorized = onUnauthorized;

//   final TokenStore _tokenStore;
//   final UnauthorizedHandler? _onUnauthorized;

//   /// Expose base url so UI can compose absolute URLs if needed
//   String get baseUrl => Env.apiBase;

//   /// Async token accessor (reflects whatever is in secure storage)
//   Future<String?> getToken() => _tokenStore.readToken();

//   Uri _u(String path, [Map<String, dynamic>? q]) =>
//       Uri.parse('${Env.apiBase}$path').replace(queryParameters: q);

//   Future<Map<String, String>> _headers(Map<String, String>? extra) async {
//     final token = await _tokenStore.readToken();
//     return {
//       'Accept': 'application/json',
//       if (token != null && token.isNotEmpty) 'Authorization': 'Bearer $token',
//       ...?extra,
//     };
//   }

//   Future<void> _handle401(int statusCode) async {
//     if (statusCode == 401 && _onUnauthorized != null) {
//       await _onUnauthorized!.call();
//     }
//   }

//   // ─────────────────────────── HTTP JSON helpers ───────────────────────────

//   Future<http.Response> get(
//     String path, {
//       Map<String, String>? headers,
//       Map<String, dynamic>? query,
//     }) async {
//     final res = await http.get(_u(path, query), headers: await _headers(headers));
//     await _handle401(res.statusCode);
//     return res;
//   }

//   Future<http.Response> post(
//     String path, {
//       Map<String, String>? headers,
//       Map<String, dynamic>? body,
//       Map<String, dynamic>? query,
//     }) async {
//     final res = await http.post(
//       _u(path, query),
//       headers: await _headers({
//         'Content-Type': 'application/json',
//         ...?headers,
//       }),
//       body: body == null ? null : jsonEncode(body),
//     );
//     await _handle401(res.statusCode);
//     return res;
//   }

//   /// Used by “Update Site”, etc.
//   Future<http.Response> put(
//     String path, {
//       Map<String, String>? headers,
//       Map<String, dynamic>? body,
//       Map<String, dynamic>? query,
//     }) async {
//     final res = await http.put(
//       _u(path, query),
//       headers: await _headers({
//         'Content-Type': 'application/json',
//         ...?headers,
//       }),
//       body: body == null ? null : jsonEncode(body),
//     );
//     await _handle401(res.statusCode);
//     return res;
//   }

//   Future<http.Response> delete(
//     String path, {
//       Map<String, String>? headers,
//       Map<String, dynamic>? query,
//     }) async {
//     final res = await http.delete(
//       _u(path, query),
//       headers: await _headers(headers),
//     );
//     await _handle401(res.statusCode);
//     return res;
//   }

//   /// Raw bytes (e.g., CSV export)
//   Future<http.Response> getBytes(
//     String path, {
//       Map<String, dynamic>? query,
//       Map<String, String>? headers,
//     }) async {
//     final res = await http.get(
//       _u(path, query),
//       headers: await _headers({
//         // do NOT set Content-Type for bytes
//         ...?headers,
//       }),
//     );
//     await _handle401(res.statusCode);
//     return res;
//   }

//   // ─────────────────────────── Multipart helper ───────────────────────────
//   /// For endpoints expecting multipart/form-data (e.g., profile picture).
//   /// `method` can be 'POST' or 'PUT'.
//   Future<http.StreamedResponse> multipart(
//     String path, {
//       String method = 'POST',
//       Map<String, String>? fields,
//       List<http.MultipartFile>? files,
//       Map<String, dynamic>? query,
//       Map<String, String>? headers,
//     }) async {
//     final uri = _u(path, query);
//     final req = http.MultipartRequest(method, uri);

//     // Auth + any extras (do NOT force JSON headers here)
//     req.headers.addAll(await _headers(headers));

//     if (fields != null) req.fields.addAll(fields);
//     if (files != null) req.files.addAll(files);

//     final streamed = await req.send();
//     await _handle401(streamed.statusCode);
//     return streamed;
//   }
// }


import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'env.dart';
import 'token_store.dart';

typedef UnauthorizedHandler = Future<void> Function();

class ApiClient {
  ApiClient(
    this._tokenStore, {
    UnauthorizedHandler? onUnauthorized,
    Duration? defaultTimeout,
  })  : _onUnauthorized = onUnauthorized,
        _defaultTimeout = defaultTimeout ?? const Duration(seconds: 30);

  final TokenStore _tokenStore;
  final UnauthorizedHandler? _onUnauthorized;
  final Duration _defaultTimeout;

  /// Expose base url so UI can compose absolute URLs if needed
  String get baseUrl => Env.apiBase;

  /// Async token accessor (reflects whatever is in secure storage)
  Future<String?> getToken() => _tokenStore.readToken();

  // ─────────────────────────── URI + Query helpers ───────────────────────────

  String _stringify(Object v) {
    if (v is DateTime) return v.toUtc().toIso8601String();
    if (v is bool) return v ? 'true' : 'false';
    return v.toString();
  }

  /// Map<String, dynamic> -> Map<String, String> (single-value encoding)
  Map<String, String> _toQuerySingle(Map<String, dynamic>? q) {
    if (q == null) return const {};
    final out = <String, String>{};
    q.forEach((key, value) {
      if (value == null) return;
      if (value is Iterable) {
        final it = value.cast<Object?>().where((e) => e != null);
        final first = it.isEmpty ? null : it.first;
        if (first != null) out[key] = _stringify(first);
      } else {
        out[key] = _stringify(value);
      }
    });
    return out;
  }

  /// Map<String, dynamic> -> Map<String, List<String>> (multi-value encoding)
  Map<String, List<String>> _toQueryAll(Map<String, dynamic>? q) {
    if (q == null) return const {};
    final out = <String, List<String>>{};
    q.forEach((key, value) {
      if (value == null) return;
      if (value is Iterable) {
        final list = value
            .cast<Object?>()
            .where((e) => e != null)
            .map((e) => _stringify(e!))
            .toList(growable: false);
        if (list.isNotEmpty) out[key] = list;
      } else {
        out[key] = [_stringify(value)];
      }
    });
    return out;
  }

  /// Encode Map<String, List<String>> into a query string (repeated keys)
  String _encodeQueryAll(Map<String, List<String>> qpAll) {
    if (qpAll.isEmpty) return '';
    final parts = <String>[];
    qpAll.forEach((key, values) {
      final k = Uri.encodeQueryComponent(key);
      for (final v in values) {
        parts.add('$k=${Uri.encodeQueryComponent(v)}');
      }
    });
    return parts.join('&');
  }

  Uri _u(String path, [Map<String, dynamic>? q]) {
    final base = Uri.parse('${Env.apiBase}$path');

    // If any value is a list/iterable, encode using repeated keys (?a=1&a=2)
    final hasList = q?.values.any((v) => v is Iterable) ?? false;
    if (hasList) {
      final qpAll = _toQueryAll(q);
      final query = _encodeQueryAll(qpAll);
      return base.replace(query: query.isEmpty ? null : query);
    }

    // Otherwise, let Uri handle standard map encoding
    return base.replace(queryParameters: _toQuerySingle(q));
  }

  Future<Map<String, String>> _headers(Map<String, String>? extra) async {
    final token = await _tokenStore.readToken();
    return {
      'Accept': 'application/json',
      if (token != null && token.isNotEmpty) 'Authorization': 'Bearer $token',
      ...?extra,
    };
    // NOTE: do NOT set Content-Type here by default—per-method does it when needed.
  }

  Future<void> _handle401(int statusCode) async {
    if (statusCode == 401 && _onUnauthorized != null) {
      await _onUnauthorized!.call();
    }
  }

  Future<T> _withTimeout<T>(Future<T> fut, [Duration? timeout]) {
    return fut.timeout(timeout ?? _defaultTimeout);
  }

  // ─────────────────────────── HTTP JSON helpers ───────────────────────────

  Future<http.Response> get(
    String path, {
    Map<String, String>? headers,
    Map<String, dynamic>? query,
    Duration? timeout,
  }) async {
    final res = await _withTimeout(
      http.get(_u(path, query), headers: await _headers(headers)),
      timeout,
    );
    await _handle401(res.statusCode);
    return res;
  }

  Future<http.Response> post(
    String path, {
    Map<String, String>? headers,
    Map<String, dynamic>? body,
    Map<String, dynamic>? query,
    Duration? timeout,
  }) async {
    final res = await _withTimeout(
      http.post(
        _u(path, query),
        headers: await _headers({
          'Content-Type': 'application/json',
          ...?headers,
        }),
        body: body == null ? null : jsonEncode(body),
      ),
      timeout,
    );
    await _handle401(res.statusCode);
    return res;
  }

  Future<http.Response> put(
    String path, {
    Map<String, String>? headers,
    Map<String, dynamic>? body,
    Map<String, dynamic>? query,
    Duration? timeout,
  }) async {
    final res = await _withTimeout(
      http.put(
        _u(path, query),
        headers: await _headers({
          'Content-Type': 'application/json',
          ...?headers,
        }),
        body: body == null ? null : jsonEncode(body),
      ),
      timeout,
    );
    await _handle401(res.statusCode);
    return res;
  }

  Future<http.Response> patch(
    String path, {
    Map<String, String>? headers,
    Map<String, dynamic>? body,
    Map<String, dynamic>? query,
    Duration? timeout,
  }) async {
    final req = http.Request('PATCH', _u(path, query))
      ..headers.addAll(await _headers({
        'Content-Type': 'application/json',
        ...?headers,
      }))
      ..body = body == null ? '' : jsonEncode(body);

    final streamed = await _withTimeout(req.send(), timeout);
    await _handle401(streamed.statusCode);
    return http.Response.fromStream(streamed);
  }

  Future<http.Response> delete(
    String path, {
    Map<String, String>? headers,
    Map<String, dynamic>? query,
    Duration? timeout,
  }) async {
    final res = await _withTimeout(
      http.delete(_u(path, query), headers: await _headers(headers)),
      timeout,
    );
    await _handle401(res.statusCode);
    return res;
  }

  /// Raw bytes (e.g., CSV export)
  Future<http.Response> getBytes(
    String path, {
    Map<String, dynamic>? query,
    Map<String, String>? headers,
    Duration? timeout,
  }) async {
    final res = await _withTimeout(
      http.get(
        _u(path, query),
        headers: await _headers({
          // Intentionally avoid 'Content-Type' here
          ...?headers,
        }),
      ),
      timeout,
    );
    await _handle401(res.statusCode);
    return res;
  }

  // ─────────────────────────── Multipart helper ───────────────────────────
  /// For endpoints expecting multipart/form-data (e.g., uploads).
  /// `method` can be 'POST', 'PUT', or 'PATCH'.
  Future<http.StreamedResponse> multipart(
    String path, {
    String method = 'POST',
    Map<String, String>? fields,
    List<http.MultipartFile>? files,
    Map<String, dynamic>? query,
    Map<String, String>? headers,
    Duration? timeout,
  }) async {
    final uri = _u(path, query);
    final req = http.MultipartRequest(method, uri);

    // Auth + any extras (do NOT force JSON headers here)
    req.headers.addAll(await _headers(headers));

    if (fields != null && fields.isNotEmpty) req.fields.addAll(fields);
    if (files != null && files.isNotEmpty) req.files.addAll(files);

    final streamed = await _withTimeout(req.send(), timeout);
    await _handle401(streamed.statusCode);
    return streamed;
  }
}
