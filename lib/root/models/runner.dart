part of '../root.dart';

/// The basic runner template.
///
/// This class initializes the [DependencyContainer] for this runner [environment],
/// and runs the application with the [runApplication] method.
abstract class Runner {
  late DependencyContainer _container;
  Future<void> run(EnvironmentChangedCallback onEnvironmentChanged) async {
    _container = await initializeContainer();
    await runApplication(_container, onEnvironmentChanged);
  }

  /// Returns initialized DependencyContainer for the [environment].
  @protected
  Future<DependencyContainer> initializeContainer();

  /// Runs application (the runApp function).
  @protected
  Future<void> runApplication(DependencyContainer container,
      EnvironmentChangedCallback onEnvironmentChanged);

  /// Cleans resources that this runner uses.
  @protected
  Future<void> clean() async {
    await _container.dispose();
  }

  /// This runner environment.
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
