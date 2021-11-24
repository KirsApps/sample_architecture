part of '../developer_part.dart';

/// Widget for display all log records
class LogScreen extends StatelessWidget {
  /// List with all log records
  final List<RenderableRecord> records;

  /// Creates [LogScreen]
  const LogScreen({Key? key, required this.records}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Log",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 17,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: GestureDetector(
              onTap: () async {
                //  final file =
                //      await ExcelConverterStrategy().convertRecords(records);
                //   await Share.shareFiles([file.path], subject: "Log");
              },
              child: const Icon(
                Icons.upload_file,
                color: Colors.white,
                size: 22,
              ),
            ),
          )
        ],
      ),
      body: RefreshIndicator(
        backgroundColor: Colors.white,
        onRefresh: () async {
          context.read<DeveloperLogBloc>().add(DeveloperLogOpened());
          await context.read<DeveloperLogBloc>().stream.first;
        },
        child: Scrollbar(
          child: ListView.separated(
            separatorBuilder: (_, __) => const Divider(),
            physics: const AlwaysScrollableScrollPhysics(),
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.all(20),
              child: records[index].render(context),
            ),
            itemCount: records.length,
          ),
        ),
      ),
    );
  }
}
