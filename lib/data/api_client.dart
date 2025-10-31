// import 'package:dio/dio.dart';

// class ApiClient {
//   final Dio _dio;

//   ApiClient(String baseUrl, {List<Interceptor>? interceptors})
//       : _dio = Dio(BaseOptions(
//           baseUrl: baseUrl,
//           connectTimeout: const Duration(seconds: 20),
//           receiveTimeout: const Duration(seconds: 20),
//           responseType: ResponseType.json,
//           headers: {'Content-Type': 'application/json'},
//         )) {
//     if (interceptors != null) _dio.interceptors.addAll(interceptors);
//   }

//   // Add auth header hook if needed
//   void setAuthToken(String token) {
//     _dio.options.headers['Authorization'] = 'Bearer $token';
//   }

//   Future<Response<T>> get<T>(
//     String path, {
//     Map<String, dynamic>? query,
//   }) async {
//     return _dio.get<T>(path, queryParameters: query);
//   }
// }



import 'package:dio/dio.dart';

class ApiClient {
  final Dio _dio;

  ApiClient(String baseUrl, {List<Interceptor>? interceptors})
      : _dio = Dio(
          BaseOptions(
            baseUrl: baseUrl,
            connectTimeout: const Duration(seconds: 20),
            receiveTimeout: const Duration(seconds: 20),
            responseType: ResponseType.json,
            headers: {'Content-Type': 'application/json'},
          ),
        ) {
    if (interceptors != null) _dio.interceptors.addAll(interceptors);
  }

  // Optional: keep using this to inject auth
  void setAuthToken(String token) {
    _dio.options.headers['Authorization'] = 'Bearer $token';
  }

  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? query,
  }) async {
    return _dio.get<T>(path, queryParameters: query);
  }

  Future<Response<T>> put<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? query,
  }) async {
    return _dio.put<T>(path, data: data, queryParameters: query);
  }

  // Used by Export (returns raw bytes)
  Future<Response<List<int>>> getBytes(
    String path, {
    Map<String, dynamic>? query,
  }) async {
    return _dio.get<List<int>>(
      path,
      queryParameters: query,
      options: Options(responseType: ResponseType.bytes),
    );
  }
}
