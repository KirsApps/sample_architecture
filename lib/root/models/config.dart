part of '../root.dart';

/// The application config.
class Config {
  /// The backend URL uses as the base URL in Dio.
  final String apiUrl;

  /// The key is for storing the logger's encryption key.
  final String deLogEncryptionKey;

  /// The key is for the logger's hive box name.
  final String deLogBoxKey;

  /// Creates the [Config] that uses
  /// the given parameters.
  Config({
    required this.apiUrl,
    required this.deLogEncryptionKey,
    required this.deLogBoxKey,
  });
}
