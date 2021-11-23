part of '../root.dart';

/// The callback with new [Environment]
typedef EnvironmentChangedCallback = Future<void> Function(Environment);

/// The Application's entry point.
///
/// This class handles app components initializing with
/// the [initializeComponents] method and then calls
/// the [runEnvironment] method with the given [environment].
/// The [Environment] change is active with the [changeEnvironment] method.
///
/// Internally this class keeps the current active runner initialized
/// in the run method and calls the runner's clean method in the [changeEnvironment] method.
abstract class Manager {
  /// The current runner
  late Runner _runner;

  /// Initializes components and runs the given [environment]
  ///
  /// This is the application entry point. The [Manager.initializeComponents()] method
  /// will be called once
  Future<void> runMain(Environment environment) async {
    await initializeComponents();
    await runEnvironment(environment);
  }

  /// Gets a runner for the given [environment] and calls the [Runner.run()] method.
  @protected
  Future<void> runEnvironment(Environment environment) async {
    _runner = getRunnerForEnvironment(environment);
    await _runner.run(changeEnvironment);
  }

  /// Cleans the current runner and runs the [Manager.runEnvironment()] method.
  @protected
  Future<void> changeEnvironment(Environment environment) async {
    await _runner.clean();
    await runEnvironment(environment);
  }

  /// Hook method
  /// This method will be called once.
  @protected
  Future<void> initializeComponents() async {}

  /// Returns a [Runner] that handles the given [environment].
  @protected
  Runner getRunnerForEnvironment(Environment environment);
}

class AppManager extends Manager {
  @override
  Runner getRunnerForEnvironment(Environment environment) {
    if (environment == Environment.prod) {
      return ProdRunner();
    } else if (environment == Environment.dev) {
      return DevRunner();
    } else if (environment == Environment.mock) {
      return MockRunner();
    } else {
      throw Exception('Runner not registered for $environment');
    }
  }
}
