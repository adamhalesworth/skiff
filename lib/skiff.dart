/// A lightweight, Future-based library for expressing CQRS principles in Dart
/// projects.
///
/// This package allows you to write smaller, more robust and testable code by
/// turning data access (or anything else you can think of) logic into first-class
/// objects with sound typing.
library skiff;

export 'src/commands/command.dart';
export 'src/commands/command_handler.dart';
export 'src/commands/command_result.dart';

export 'src/queries/query.dart';
export 'src/queries/query_handler.dart';

export 'src/handler.dart' show FuncHandler;

export 'src/mediator.dart';
