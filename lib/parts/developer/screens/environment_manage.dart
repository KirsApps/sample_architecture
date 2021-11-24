part of '../developer_part.dart';

/// Widget for show and change app [Environment]
class EnvironmentManage extends StatelessWidget {
  /// Creates [EnvironmentManage]
  const EnvironmentManage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final container = context.read<DependencyContainer>();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Environment",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 17,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Environment'),
                DropdownButton<Environment>(
                  value: container.environment,
                  items: Environment.values
                      .map(
                        (e) => DropdownMenuItem<Environment>(
                          value: e,
                          child: Text(describeEnum(e)),
                        ),
                      )
                      .toList(),
                  onChanged: (environment) => context
                      .read<EnvironmentCubit>()
                      .changeEnvironment(environment!),
                )
              ],
            ),
            TextButton(
              onPressed: () => Navigator.of(context).push<void>(
                MaterialPageRoute(
                  builder: (_) => BlocProvider(
                    create: (context) => DeveloperLogBloc<HiveRecord>(
                      loader: container.paginationLogLoader,
                    )..add(DeveloperLogOpened()),
                    child: const DeveloperLogBuilder(),
                  ),
                ),
              ),
              child: const Text('Open Log'),
            )
          ],
        ),
      ),
    );
  }
}
