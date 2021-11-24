part of '../root.dart';

/// Returns initialized [DeLog] instance with [HiveQueueLogHandler]
/// and [PrintHandler] if the app isn't in release mode.
DeLog<DeLogRecord> initializeDeLog(HiveQueueLogHandler hiveHandler) =>
    DeLog<DeLogRecord>(
      [if (!foundation.kReleaseMode) PrintHandler(), hiveHandler],
    );
