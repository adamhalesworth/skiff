import 'dart:async';

import 'request.dart';

/// Defines an abstract handler
abstract class Handler<R extends Request, Rs> {
  /// Handles the [request], and returns a [Future] that completes with
  /// response type [Rs].
  ///
  /// It's expected that the operation being performed is non-blocking because
  /// this fits with most use cases. If the operation is simple, return a
  /// completed [Future] using `Future.value(result)`.
  Future<Rs> execute(R request);
}

typedef ExecuteCommand<R, Rs> = Future<Rs> Function(R);

/// A [Handler] that has its work to perform defined via a function.
///
/// This is generally handy for testing or quick prototyping, but in production
/// should probably be replaced with a concrete [Handler] subclass which
/// better expresses your intent.
class FuncHandler<R extends Request, Rs> implements Handler<R, Rs> {
  final ExecuteCommand<R, Rs> _fn;

  FuncHandler(this._fn);

  @override
  Future<Rs> execute(R request) {
    return _fn(request);
  }
}
