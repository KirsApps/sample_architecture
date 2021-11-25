part of '../developer_part.dart';

/// The widget displays all log records.
class LogScreen extends StatefulWidget {
  /// The log records list.
  final List<RenderableRecord> records;

  /// Creates the [LogScreen] that shows [records].
  const LogScreen({Key? key, required this.records}) : super(key: key);

  @override
  _LogScreenState createState() => _LogScreenState();
}

class _LogScreenState extends State<LogScreen> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

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
              onTap: () =>
                  context.read<DeveloperLogBloc>().add(DeveloperLogExtracted()),
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
          context.read<DeveloperLogBloc>().add(DeveloperLogRefreshed());
          await context.read<DeveloperLogBloc>().stream.first;
        },
        child: Scrollbar(
          child: ListView.separated(
            controller: _scrollController,
            separatorBuilder: (_, __) => const Divider(),
            physics: const AlwaysScrollableScrollPhysics(),
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.all(20),
              child: widget.records[index].render(context),
            ),
            itemCount: widget.records.length,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) context.read<DeveloperLogBloc>().add(DeveloperLogFetched());
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}
