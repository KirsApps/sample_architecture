part of '../root.dart';

/// Applications config
class Config {
  /// Backend api url, used as base url in Dio
  final String apiUrl;

  ///Creates application config, [apiUrl] must be a valid url
  Config({required this.apiUrl});
}
