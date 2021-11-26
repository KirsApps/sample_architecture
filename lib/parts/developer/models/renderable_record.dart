part of '../developer_part.dart';

/// The record renders as a widget.
abstract class RenderableRecord {
  /// Returns a widget that represents record data.
  Widget render(BuildContext context);
}
