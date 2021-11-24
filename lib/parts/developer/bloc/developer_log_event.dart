part of '../developer_part.dart';

/// The base event for the [DeveloperLogBloc]
abstract class DeveloperLogEvent {}

/// The event called then the screen with log opens.
class DeveloperLogFetched extends DeveloperLogEvent {}
