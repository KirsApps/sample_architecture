part of '../developer_part.dart';

/// The widget contains the [BlocBuilder] for the [DeveloperLogBloc].
class DeveloperLogBuilder extends StatelessWidget {
  /// Creates the [DeveloperLogBuilder] that contains the [BlocBuilder]
  /// for the [DeveloperLogBloc].
  const DeveloperLogBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DeveloperLogBloc, DeveloperLogState>(
      builder: (context, state) {
        if (state.status == DeveloperLogStatus.success) {
          return LogScreen(records: state.records);
        } else if (state.status == DeveloperLogStatus.failure) {
          return Container(
            alignment: Alignment.center,
            color: Colors.white,
            child: const Text('Failed to open log'),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        }
      },
    );
  }
}
