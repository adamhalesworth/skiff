import 'dart:async';

/// A marker interface for queries.
abstract class Query {}

/// Defines an abstract query handler
abstract class QueryHandler<Q extends Query, R> {
  /// Handles the [query], and returns a [Future] that completes to a
  /// result of Type [R].
  ///
  /// Here we expect that the operation being performed is non-blocking because
  /// this fits with most use cases. If the operation is simple, just return a
  /// completed [Future] using `Future.value(result)`.
  Future<R> get(Q query);
}

typedef ExecuteQuery<Q, R> = Future<R> Function(Q);

/// A [QueryHandler] whose work to perform is defined via a function.
///
/// This is generally handy for testing or quick prototyping, but in production
/// should probably be replaced with a concrete [QueryHandler] subclass which
/// better expresses your intent.
class SimpleQueryHandler<Q extends Query, R> implements QueryHandler<Q, R> {
  final ExecuteQuery<Q, R> _fn;

  SimpleQueryHandler(this._fn);

  @override
  Future<R> get(Q query) {
    return _fn(query);
  }
}
