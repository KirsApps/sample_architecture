part of '../root.dart';

/// Returns initialized [DeLog] instance with [HiveQueueLogHandler]
/// and [PrintHandler] if the app isn't in release mode.
Future<DeLog<DeLogRecord>> initializeDeLog(Config config) async {
  List<int> bytesKey;
  final String? hexKey =
      await const FlutterSecureStorage().read(key: config.deLogEncryptionKey);
  if (hexKey != null) {
    bytesKey = hexDecode(hexKey);
  } else {
    bytesKey = Hive.generateSecureKey();
    await const FlutterSecureStorage().write(
      key: config.deLogEncryptionKey,
      value: hexEncode(Uint8List.fromList(bytesKey)),
    );
  }
  final _box = await Hive.openBox<Map>(
    config.deLogBoxKey,
    encryptionCipher: HiveAesCipher(bytesKey),
  );
  return DeLog<DeLogRecord>([
    if (!foundation.kReleaseMode) PrintHandler(),
    HiveQueueLogHandler(_box)
  ]);
}
