part of '../ui_kit.dart';

// ignore: avoid_classes_with_only_static_members
/// The class stores the application themes.
class AppTheme {
  /// Returns the light [ThemeData] that the application uses.
  static ThemeData get light {
    return ThemeData.light();
  }

  /// Returns the dark [ThemeData] that the application uses.
  static ThemeData get dark {
    return ThemeData.dark();
  }
}
