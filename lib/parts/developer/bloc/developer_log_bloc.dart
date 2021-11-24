part of '../developer_part.dart';

/// Bloc for loading log records
class DeveloperLogBloc<TRecord extends RenderableRecord>
    extends Bloc<DeveloperLogEvent, DeveloperLogState> {
  /// Creates [DeveloperLogBloc]
  DeveloperLogBloc({required this.loader})
      : super(DeveloperLogState(records: []));
  final PaginationLogLoader<TRecord> loader;
}
