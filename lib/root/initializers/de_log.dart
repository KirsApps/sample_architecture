part of '../root.dart';

/// Returns the initialized [DeLog] instance with the [HiveQueueLogHandler]
/// and the [PrintHandler] if the app isn't in release mode.
DeLog<DeLogRecord> initializeDeLog(HiveQueueLogHandler hiveHandler) =>
    DeLog<DeLogRecord>(
      [if (!foundation.kReleaseMode) PrintHandler(), hiveHandler],
    );
