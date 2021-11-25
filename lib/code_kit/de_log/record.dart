part of 'de_log_kit.dart';

/// The extension that converts [RecordData<LogRecord>] to [HiveRecord].
extension RecordDataToHive on RecordData<DeLogRecord> {
  /// Returns [HiveRecord] that creates from this.
  HiveRecord get toHiveRecord => HiveRecord(level, record);
}

/// The extension returns the [Color] that represents the [Level].
extension LevelColor on Level {
  /// Returns the [Color] that represents the [Level].
  Color get color {
    switch (this) {
      case Level.trace:
        return Colors.black12;
      case Level.debug:
        return Colors.brown;
      case Level.info:
        return Colors.black;
      case Level.warn:
        return Colors.deepOrange;
      case Level.error:
        return Colors.red;
      case Level.fatal:
        return Colors.red;
    }
  }
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
      'error': error.toString(),
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

  /// Creates the [HiveRecord] that uses given parameters.
  HiveRecord(this.level, this.logRecord);

  /// Returns json that represents this.
  Map<String, dynamic> toJson() {
    return {
      'level': level.toString(),
      'logRecord': logRecord.toJson(),
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
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Level: ${describeEnum(level)}',
            style: TextStyle(
              color: level.color,
            ),
          ),
          ...logRecord
              .toJson()
              .entries
              .where(
                (element) =>
                    element.value != null && element.key != 'stackTrace',
              )
              .map(
                (e) => Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    '${e.key}: ${e.value}',
                    style: TextStyle(
                      color: level.color,
                    ),
                  ),
                ),
              )
        ],
      ),
    );
  }
}
