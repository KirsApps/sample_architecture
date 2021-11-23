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
    /// Here you return different configs for each environment.
    return Config(
      apiUrl: '',
      deLogEncryptionKey: 'deLogKey',
      deLogBoxKey: 'deLogBoxKey',
    );
  }
}
