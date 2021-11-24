part of '../developer_part.dart';

/// The record renders as a widget.
abstract class RenderableRecord {
  /// Returns the widget that represents the record data.
  Widget render(BuildContext context);
}
