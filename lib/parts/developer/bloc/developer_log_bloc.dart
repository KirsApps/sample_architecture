part of '../developer_part.dart';

const _recordsLimit = 20;
const throttleDuration = Duration(milliseconds: 200);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

/// Bloc for loading log records
class DeveloperLogBloc extends Bloc<DeveloperLogEvent, DeveloperLogState> {
  /// Creates [DeveloperLogBloc]
  DeveloperLogBloc({required this.loader, required this.logger})
      : super(DeveloperLogState(records: [])) {
    on<DeveloperLogFetched>(
      _onRecordsFetched,
      transformer: throttleDroppable(throttleDuration),
    );
  }
  final PaginationLogLoader loader;
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
}
