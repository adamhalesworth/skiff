import 'package:skiff/src/handler.dart';
import 'package:skiff/src/queries/query.dart';

/// A marker interface for query handlers.
abstract class QueryHandler<Q extends Query, Rs> implements Handler<Q, Rs> {}
