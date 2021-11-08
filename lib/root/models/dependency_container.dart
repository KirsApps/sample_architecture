part of '../root.dart';

/// Dependency injection container.
///
/// Contains all application dependencies.
class DependencyContainer {
  /// Application config
  final Config config;

  /// Application environment
  final Environment environment;

  /// Dio instance for requests to backend
  final Dio dio;

  ///Creates RootContainer
  DependencyContainer._({
    required this.config,
    required this.dio,
    required this.environment,
  });

  /// Returns initialized DependencyContainer for [environment]
  static Future<DependencyContainer> initializeFromEnv(
      Environment environment) async {
    final config = environment.config();
    final dio = initializeDio(config.apiUrl);
    return DependencyContainer._(
      config: config,
      dio: dio,
      environment: environment,
    );
  }
}
