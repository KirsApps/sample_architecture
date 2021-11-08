import 'package:bloc/bloc.dart';
import 'package:sample_architecture/root/root.dart';

/// Cubit used to store and modify the dependency container
class EnvironmentCubit extends Cubit<DependencyContainer> {
  /// Creates Bloc
  EnvironmentCubit(DependencyContainer container) : super(container);

  /// Yields new state with [DependencyContainer] for [environment]
  Future<void> changeEnvironment(Environment environment) async {
    final container = await DependencyContainer.initializeFromEnv(environment);
    emit(container);
  }

  /// Yields new state with [DependencyContainer] for current [environment]
  Future<void> reInitialize() => changeEnvironment(state.environment);
}
