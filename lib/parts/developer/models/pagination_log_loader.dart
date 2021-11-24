part of '../developer_part.dart';

/// The abstract class for pagination load stored log records.
abstract class PaginationLogLoader {
  /// Returns [take] count of data from [skip] position.
  Future<List<RenderableRecord>> fetch(int offset, int take);
}
