part of '../developer_part.dart';

/// The abstract class for pagination load stored log records.
abstract class PaginationLogLoader<T> {
  /// Returns [take] count of data from [skip] position.
  Future<List<T>> fetch(int offset, int take);
}
