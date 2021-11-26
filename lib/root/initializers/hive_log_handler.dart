part of '../root.dart';

/// Returns the initialized [HiveQueueLogHandler] instance that uses the encrypted box.
Future<HiveQueueLogHandler> initializeHiveLogHandler(Config config) =>
    runZonedGuarded<Future<HiveQueueLogHandler>>(
      () async {
        List<int> bytesKey;
        final hexKey = await const FlutterSecureStorage()
            .read(key: config.deLogEncryptionKey);
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
        return HiveQueueLogHandler(_box);
      },

      /// Here you can handle errors in the low-level error handlers such as Firebase, Sentry.
      (error, stackTrace) => print(
        'error in create HiveQueueLogHandler instance \nerror: $error \n stackTrace: $stackTrace',
      ),
    )!;
