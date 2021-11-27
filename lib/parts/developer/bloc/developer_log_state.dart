part of '../developer_part.dart';

/// The status of the log records fetching process.
enum DeveloperLogStatus {
  /// The initial status.
  initial,

  /// The success status.
  success,

  /// The failure status.
  failure
}

/// The state is with the status, records, and the hasReachedMax data.
class DeveloperLogState {
  /// Creates the state that uses given parameters.
  DeveloperLogState({
    required this.records,
    this.status = DeveloperLogStatus.initial,
    this.hasReachedMax = false,
  });

  /// The records fetching status.
  final DeveloperLogStatus status;

  /// The log records.
  final List<RenderableRecord> records;

  /// Whether no more records exist.
  final bool hasReachedMax;

  /// The copyWith method.
  DeveloperLogState copyWith({
    DeveloperLogStatus? status,
    List<RenderableRecord>? records,
    bool? hasReachedMax,
  }) {
    return DeveloperLogState(
      status: status ?? this.status,
      records: records ?? this.records,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }
}
