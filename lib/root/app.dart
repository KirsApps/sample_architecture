part of 'root.dart';

/// The application root widget.
class App extends StatefulWidget {
  /// The [DependencyContainer] for dependency injection.
  final DependencyContainer container;

  /// The [Environment] change callback.
  final EnvironmentChangedCallback onEnvironmentChanged;

  /// Creates the application root widget that uses
  /// the given parameters.
  const App({
    Key? key,
    required this.container,
    required this.onEnvironmentChanged,
  }) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => EnvironmentCubit(widget.container.environment),
      child: BlocListener<EnvironmentCubit, Environment>(
        listener: (context, environment) =>
            widget.onEnvironmentChanged(environment),
        child: Provider<DependencyContainer>.value(
          value: widget.container,
          child: MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
          ),
        ),
      ),
    );
  }
}
