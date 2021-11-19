part of '../root.dart';

typedef EnvironmentChangedCallback = Future<void> Function(Environment);

abstract class Manager {
  Future<void> runMain(Environment environment) async {
    await initializeComponents();
    await runEnvironment(environment);
  }

  @protected
  Future<void> runEnvironment(Environment environment) async {
    await getRunnerForEnvironment(environment).run(runEnvironment);
  }

  /// Hook method
  /// This method will be called once.
  @protected
  Future<void> initializeComponents() async {}

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
