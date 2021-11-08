part of '../root.dart';

/// Returns initialized [Dio] instance with [AppLoggerInterceptor]
Dio initializeDio(String baseUrl) {
  final dio = Dio(BaseOptions(baseUrl: baseUrl, headers: <String, dynamic>{
    'accept': 'text/plain',
    'content-Type': 'application/json'
  }));
  return dio;
}
