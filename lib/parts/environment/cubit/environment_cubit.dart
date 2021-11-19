import 'package:bloc/bloc.dart';
import 'package:sample_architecture/root/root.dart';

/// Cubit used to show current [Environment]
class EnvironmentCubit extends Cubit<Environment> {
  /// Creates Cubit
  EnvironmentCubit(Environment environment) : super(environment);

  /// Yields new state with new [environment]
  void changeEnvironment(Environment environment) => emit(environment);
}
