part of '../root.dart';

/// Returns the initialized [Dio] instance that uses the [DeLogInterceptor].
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
  dio.interceptors.add(
    DeLogInterceptor(
      logger: logger,
      requestHeader: false,
      requestBody: false,
      responseBody: false,
    ),
  );
  return dio;
}
