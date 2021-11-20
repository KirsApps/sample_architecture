import 'package:bloc/bloc.dart';
import 'package:sample_architecture/root/root.dart';

/// The cubit is for showing and changing [Environment].
class EnvironmentCubit extends Cubit<Environment> {
  /// Creates the [EnvironmentCubit] that uses
  /// the given [environment] as the initial state.
  EnvironmentCubit(Environment environment) : super(environment);

  /// Yields new state with new [environment]
  void changeEnvironment(Environment environment) => emit(environment);
}
