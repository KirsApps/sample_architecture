part of '../root.dart';

/// The application environments.
enum Environment {
  /// Production
  prod,

  /// Development
  dev,

  /// Mock
  mock,
}

/// Extension on the [Environment] to return the [Config]
/// associated with this [Environment]
extension EnvironmentConfig on Environment {
  /// Returns the [Config] that is associated with this.
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
