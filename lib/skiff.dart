/// A lightweight, Future-based library for expressing CQRS principles in Dart
/// projects.
///
/// This package allows you to write smaller, more robust and testable code by
/// turning data access (or anything else you can think of) logic into first-class
/// objects with sound typing.
library skiff;

export 'src/handler.dart';
export 'src/request.dart';
export 'src/request_result.dart';
export 'src/mediator.dart';
export 'src/exceptions.dart';
