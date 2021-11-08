part of 'root.dart';

///Launches the application with dependencies in [rootContainer]
void runApplication(DependencyContainer rootContainer) {
  final debugOptions = CatcherOptions(
      SilentReportMode(),
      [
        ConsoleHandler(
            enableApplicationParameters: false, enableDeviceParameters: false),
      ],
      reportOccurrenceTimeout: 100);
  Catcher(
    rootWidget: App(
      rootContainer: rootContainer,
    ),
    debugConfig: debugOptions,
    releaseConfig: debugOptions,
    enableLogger: false,
  );
}

///Application root widget
class App extends StatefulWidget {
  ///Initial [DependencyContainer] for dependency injection
  final DependencyContainer rootContainer;

  ///Creates application root widget
  const App({Key? key, required this.rootContainer}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  /// Instance of [RootRouter]
  RootRouter _rootRouter = RootRouter(Catcher.navigatorKey);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => EnvironmentCubit(widget.rootContainer),
      child: BlocConsumer<EnvironmentCubit, DependencyContainer>(
          listener: (context, state) {
            _rootRouter = RootRouter(Catcher.navigatorKey);
          },
          builder: (context, container) => Provider<DependencyContainer>.value(
                value: container,
                key: ValueKey<DependencyContainer>(container),
                child: MaterialApp.router(
                  routerDelegate: _rootRouter.delegate(
                    initialRoutes: [const AppSplashRoute()],
                    placeholder: (_) => const AppSplashScreen(),
                  ),
                  routeInformationParser: _rootRouter.defaultRouteParser(),
                  localizationsDelegates:
                      AppLocalizations.localizationsDelegates,
                  supportedLocales: AppLocalizations.supportedLocales,
                  theme: AppTheme.light,
                ),
              )),
    );
  }
}
