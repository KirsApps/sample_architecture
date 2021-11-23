library de_log_kit;

import 'package:data_queue/data_queue.dart';
import 'package:de_log/de_log.dart';
import 'package:hive/hive.dart';

part 'record.dart';

/// The class prints all records.
class PrintHandler extends LogHandler<DeLogRecord> {
  @override
  void handle(RecordData<DeLogRecord> data) {
    //ignore:avoid_print
    print(data.record);
  }

  @override
  Future<void> dispose() async {}
}

/// The class stores all records in the hive.
class HiveQueueLogHandler extends QueueLogHandler<DeLogRecord> {
  /// The box for records storing.
  final Box box;

  /// Creates [HiveQueueLogHandler] that stores all records in the hive.
  HiveQueueLogHandler(this.box);
  @override
  Future<void> handleRecords() async {
    try {
      final recordData = await worker.next;
      await box.add(recordData.toHiveRecord);
      await handleRecords();
    } on TerminatedException {
      await box.close();
    }
  }
}
