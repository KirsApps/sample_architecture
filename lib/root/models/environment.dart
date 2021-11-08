part of '../root.dart';

/// Applications environments
enum Environment {
  /// Production
  prod,

  /// Development
  dev,

  /// Mock
  mock,
}

/// Extension on [Environment] to return [Config]
/// associated with this [Environment]
extension EnvironmentConfig on Environment {
  ///Returns [Config] associated with this
  Config config() {
    if (this == Environment.prod) {
      return Config(
        apiUrl: 'apiUrl',
      );
    } else if (this == Environment.dev) {
      return Config(
        apiUrl: 'apiUrl',
      );
    } else {
      return Config(
        apiUrl: '',
      );
    }
  }
}
