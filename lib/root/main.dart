part of 'root.dart';

///General function for initialize main
Future<void> runMain(Environment environment) async {
  WidgetsFlutterBinding.ensureInitialized();
  final applicationDirectory = await getApplicationDocumentsDirectory();
  initializeHive(applicationDirectory.path);
  final container = await DependencyContainer.initializeFromEnv(environment);
  runApplication(container);
}
