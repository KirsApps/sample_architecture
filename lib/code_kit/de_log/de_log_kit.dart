library de_log_kit;

import 'dart:convert';

import 'package:data_queue/data_queue.dart';
import 'package:de_log/de_log.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:sample_architecture/parts/developer/developer_part.dart';

part 'de_log_interceptor.dart';
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
class HiveQueueLogHandler extends QueueLogHandler<DeLogRecord>
    implements PaginationLogLoader {
  /// The box for records storing.
  final Box<Map> box;

  /// Creates [HiveQueueLogHandler] that stores all records in the hive.
  HiveQueueLogHandler(this.box);
  @override
  Future<void> handleRecords() async {
    try {
      final recordData = await worker.next;
      await box.add(recordData.toHiveRecord.toJson());
      await handleRecords();
    } on TerminatedException {
      await box.close();
    }
  }

  @override
  Future<List<HiveRecord>> fetch(int offset, int take) async => box
      .valuesBetween(startKey: offset, endKey: offset + take)
      .map((e) => HiveRecord.fromJson(e))
      .toList();
}
