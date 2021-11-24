part of '../developer_part.dart';

/// base event for [DeveloperLogBloc]
@immutable
abstract class DeveloperLogEvent {}

/// event called then screen with log opens
class DeveloperLogOpened extends DeveloperLogEvent {}
