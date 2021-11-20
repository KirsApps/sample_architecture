part of '../root.dart';

/// The dependency injection container.
///
/// This container contains all application dependencies.
class DependencyContainer {
  /// The Application config.
  final Config config;

  /// The Application environment.
  final Environment environment;

  /// The  Dio instance that this container uses.
  final Dio dio;

  /// Creates the [DependencyContainer] that uses
  /// the given parameters.
  DependencyContainer({
    required this.config,
    required this.dio,
    required this.environment,
  });

  /// Frees resources that this container use.
  Future<void> dispose() async {}
}
