part of 'de_log_kit.dart';

/// The extension that converts [RecordData<LogRecord>] to [HiveRecord].
extension RecordDataToHive on RecordData<DeLogRecord> {
  /// Returns [HiveRecord] that creates from this.
  HiveRecord get toHiveRecord => HiveRecord(level, record);
}

/// The log record data.
class DeLogRecord {
  /// The log message.
  final String message;

  /// The time when this record was created.
  final DateTime time;

  /// The name of the source of the log message.
  final String name;

  /// An error object associated with this log event.
  final dynamic error;

  /// A stack trace associated with this log event.
  final StackTrace stackTrace;

  /// Creates the [DeLogRecord] that uses given parameters.
  DeLogRecord(
    this.message, {
    this.name = '',
    this.error,
    StackTrace? stackTrace,
    DateTime? time,
  })  : stackTrace = stackTrace ?? StackTrace.current,
        time = time ?? DateTime.now();

  /// Returns json that represents this.
  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'time': time.toString(),
      'name': name,
      'error': error,
      'stackTrace': stackTrace.toString(),
    };
  }

  /// Returns the [DeLogRecord] that generates from the given [json].
  factory DeLogRecord.fromJson(dynamic json) {
    return DeLogRecord(
      json['message'] as String,
      time: DateTime.parse(json['time'] as String),
      name: json['name'] as String,
      error: json['error'],
      stackTrace: StackTrace.fromString(json['stackTrace'] as String),
    );
  }

  @override
  String toString() =>
      '$time - [$name] $message ${error != null ? '\n$error' : ''} \n$stackTrace';
}

/// The class contains the [Level] and the [DeLogRecord].
class HiveRecord implements RenderableRecord {
  /// The log level.
  final Level level;

  /// The log record.
  final DeLogRecord logRecord;
  HiveRecord(this.level, this.logRecord);

  /// Returns json that represents this.
  Map<String, dynamic> toJson() {
    return {
      'level': level.toString(),
      'logRecord': logRecord,
    };
  }

  /// Returns the [HiveRecord] that generates from the given [json].
  factory HiveRecord.fromJson(dynamic json) {
    return HiveRecord(
      Level.values.firstWhere(
        (element) => element.toString() == json['level'] as String,
      ),
      DeLogRecord.fromJson(json['logRecord']),
    );
  }

  @override
  Widget render(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: ListTile.divideTiles(
          tiles: [
            Text('Level: ${describeEnum(level)}'),
            ...logRecord
                .toJson()
                .entries
                .where((element) => element.value != null)
                .map(
                  (e) => Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text('${e.key}: ${e.value}'),
                  ),
                )
          ],
        ).toList(),
      ),
    );
  }
}
