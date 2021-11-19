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
  DependencyContainer({
    required this.config,
    required this.dio,
    required this.environment,
  });
}
