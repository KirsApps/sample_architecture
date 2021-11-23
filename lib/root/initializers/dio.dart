part of '../root.dart';

/// Returns initialized [Dio] instance with [AppLoggerInterceptor]
Dio initializeDio(String baseUrl, DeLog logger) {
  final dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      headers: <String, dynamic>{
        'accept': 'text/plain',
        'content-Type': 'application/json'
      },
    ),
  );
  dio.interceptors.add(DeLogInterceptor(logger: logger));
  return dio;
}
