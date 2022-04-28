import 'dart:collection';

import 'package:skiff/src/handler.dart';
import 'package:skiff/src/request.dart';

/// Takes a [Request] and passes it to an appropriate [Handler].
abstract class Relay {
  UnmodifiableMapView<Type, Handler> get handlers;

  /// Adds a handler for the request type [R].
  ///
  /// This [handler] will be registered against the type [R] and executed
  /// whenever a [Request] of that type is dispatched.
  void addHandler<R extends Request>(Handler<R, dynamic> handler);

  /// Removes a handler for the request type [R].
  Handler<Request<dynamic>, dynamic> removeHandler<R extends Request>();

  /// Passes the given [request] to a registered handler and returns a response
  /// of type [Rs].
  Future<Rs> dispatch<Rs>(Request<Rs> request);
}
