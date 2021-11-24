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

  /// The logger.
  final DeLog<DeLogRecord> logger;

  /// The log records loader that the developer_part uses.
  final PaginationLogLoader<HiveRecord> paginationLogLoader;

  /// Creates the [DependencyContainer] that uses
  /// the given parameters.
  DependencyContainer({
    required this.config,
    required this.dio,
    required this.environment,
    required this.logger,
    required this.paginationLogLoader,
  });

  /// Frees resources that this container use.
  Future<void> dispose() async {
    await logger.dispose();
  }
}
