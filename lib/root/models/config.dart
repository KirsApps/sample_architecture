part of '../root.dart';

/// The application config.
class Config {
  /// The backend URL uses as the base URL in Dio.
  final String apiUrl;

  /// Creates the [Config] that uses
  /// the given parameters.
  Config({required this.apiUrl});
}
