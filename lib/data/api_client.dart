import 'package:dio/dio.dart';

class ApiClient {
  final Dio _dio;

  ApiClient(String baseUrl, {List<Interceptor>? interceptors})
      : _dio = Dio(BaseOptions(
          baseUrl: baseUrl,
          connectTimeout: const Duration(seconds: 20),
          receiveTimeout: const Duration(seconds: 20),
          responseType: ResponseType.json,
          headers: {'Content-Type': 'application/json'},
        )) {
    if (interceptors != null) _dio.interceptors.addAll(interceptors);
  }

  // Add auth header hook if needed
  void setAuthToken(String token) {
    _dio.options.headers['Authorization'] = 'Bearer $token';
  }

  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? query,
  }) async {
    return _dio.get<T>(path, queryParameters: query);
  }
}
