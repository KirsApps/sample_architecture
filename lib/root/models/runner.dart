part of '../root.dart';

abstract class Runner {
  Future<void> run(EnvironmentChangedCallback onEnvironmentChanged) async {
    final container = await initializeContainer();
    await runApplication(container, onEnvironmentChanged);
  }

  /// Returns initialized DependencyContainer for [environment]
  @protected
  Future<DependencyContainer> initializeContainer();

  Future<void> runApplication(DependencyContainer container,
      EnvironmentChangedCallback onEnvironmentChanged);

  Environment get environment;
}

abstract class AppRunner extends Runner {
  @override
  Future<DependencyContainer> initializeContainer() async {
    final config = environment.config();
    final dio = initializeDio(config.apiUrl);
    return DependencyContainer(
      config: config,
      dio: dio,
      environment: environment,
    );
  }

  @override
  Future<void> runApplication(DependencyContainer container,
      EnvironmentChangedCallback onEnvironmentChanged) async {
    runApp(App(
      key: ValueKey<DependencyContainer>(container),
      container: container,
      onEnvironmentChanged: onEnvironmentChanged,
    ));
  }
}

abstract class CatcherRunner extends AppRunner {
  @override
  Future<void> runApplication(DependencyContainer container,
      EnvironmentChangedCallback onEnvironmentChanged) async {
    final debugOptions = CatcherOptions(
        SilentReportMode(),
        [
          ConsoleHandler(
              enableApplicationParameters: false,
              enableDeviceParameters: false),
        ],
        reportOccurrenceTimeout: 100);
    Catcher(
      runAppFunction: () =>
          super.runApplication(container, onEnvironmentChanged),
      debugConfig: debugOptions,
      releaseConfig: debugOptions,
      enableLogger: false,
    );
  }
}

class DevRunner extends CatcherRunner {
  @override
  Environment get environment => Environment.dev;
}

class ProdRunner extends CatcherRunner {
  @override
  Environment get environment => Environment.prod;
}

class MockRunner extends CatcherRunner {
  @override
  Environment get environment => Environment.prod;
}
