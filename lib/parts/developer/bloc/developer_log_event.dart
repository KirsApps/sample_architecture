part of '../developer_part.dart';

/// The base event that the [DeveloperLogBloc] uses.
abstract class DeveloperLogEvent {}

/// Records fetched.
class DeveloperLogFetched extends DeveloperLogEvent {}

/// Records refreshed.
class DeveloperLogRefreshed extends DeveloperLogEvent {}

/// Records extracted.
class DeveloperLogExtracted extends DeveloperLogEvent {}
