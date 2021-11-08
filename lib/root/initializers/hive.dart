part of '../root.dart';

///Initializing Hive with given [path]
///
/// This function must be called before any [Hive] use.
void initializeHive(String path) {
  Hive.init(path);
}
