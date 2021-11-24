part of '../developer_part.dart';

/// Widget with [BlocBuilder] for [DeveloperLogBloc]
class DeveloperLogBuilder extends StatelessWidget {
  /// Creates [DeveloperLogBuilder]
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
