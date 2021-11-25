part of '../developer_part.dart';

const _recordsLimit = 20;

const _throttleDuration = Duration(milliseconds: 200);

EventTransformer<E> _throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

/// The bloc loads log records.
class DeveloperLogBloc extends Bloc<DeveloperLogEvent, DeveloperLogState> {
  /// Creates the [DeveloperLogBloc] that loads log records.
  DeveloperLogBloc({required this.loader, required this.logger})
      : super(DeveloperLogState(records: [])) {
    on<DeveloperLogFetched>(
      _onRecordsFetched,
      transformer: _throttleDroppable(_throttleDuration),
    );
    on<DeveloperLogRefreshed>(
      _onRecordsRefreshed,
      transformer: sequential(),
    );
    on<DeveloperLogExtracted>(
      _onRecordsExtracted,
      transformer: sequential(),
    );
  }

  /// The [PaginationLogLoader] instance.
  final PaginationLogLoader loader;

  /// The [DeLog<DeLogRecord>] instance.
  final DeLog<DeLogRecord> logger;

  Future<void> _onRecordsFetched(
    DeveloperLogFetched event,
    Emitter<DeveloperLogState> emit,
  ) async {
    if (state.hasReachedMax) return;
    try {
      if (state.status == DeveloperLogStatus.initial) {
        final records = await loader.fetch(0, _recordsLimit);
        return emit(
          state.copyWith(
            status: DeveloperLogStatus.success,
            records: records,
            hasReachedMax: false,
          ),
        );
      }
      final records = await loader.fetch(state.records.length, _recordsLimit);
      records.isEmpty
          ? emit(state.copyWith(hasReachedMax: true))
          : emit(
              state.copyWith(
                status: DeveloperLogStatus.success,
                records: List.of(state.records)..addAll(records),
                hasReachedMax: false,
              ),
            );
    } catch (e, s) {
      logger.error(
        DeLogRecord(
          'Failed to load log records',
          name: 'DeveloperLogBloc -> _onRecordsFetched',
          error: e,
          stackTrace: s,
        ),
      );
      emit(state.copyWith(status: DeveloperLogStatus.failure));
    }
  }

  Future<void> _onRecordsRefreshed(
    DeveloperLogRefreshed event,
    Emitter<DeveloperLogState> emit,
  ) async {
    emit(state.copyWith(status: DeveloperLogStatus.initial));
    add(DeveloperLogFetched());
  }

  Future<void> _onRecordsExtracted(
    DeveloperLogExtracted event,
    Emitter<DeveloperLogState> emit,
  ) async {
    final records = await loader.fetchAll();
    final file = File("${(await getTemporaryDirectory()).path}/log.json")
      ..create()
      ..writeAsString(jsonEncode(records));
    await Share.shareFiles([file.path], subject: "Log");
  }
}
