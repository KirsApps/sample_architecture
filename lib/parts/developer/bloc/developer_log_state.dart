part of '../developer_part.dart';

enum DeveloperLogStatus { initial, success, failure }

class DeveloperLogState {
  DeveloperLogState({
    required this.records,
    this.status = DeveloperLogStatus.initial,
    this.hasReachedMax = false,
  });

  final DeveloperLogStatus status;
  final List<RenderableRecord> records;
  final bool hasReachedMax;

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
