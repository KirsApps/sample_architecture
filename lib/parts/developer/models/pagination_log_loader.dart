part of '../developer_part.dart';

/// The abstract class for pagination load stored log records.
abstract class PaginationLogLoader {
  /// Returns the [take] count of records from the [skip] position if they exist.
  Future<List<RenderableRecord>> fetch(int offset, int take);

  /// Returns all log records that exist.
  Future<List<RenderableRecord>> fetchAll();
}
