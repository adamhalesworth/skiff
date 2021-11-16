import 'dart:async';
import 'dart:collection';

import 'package:skiff/src/exceptions.dart';
import 'package:skiff/src/handler.dart';
import 'package:skiff/src/request.dart';

/// Promotes loose coupling between caller and callees.
class Mediator {
  final Map<Type, Handler> _handlers = {};

  /// Gets the currently registered handlers for this [Mediator].
  UnmodifiableMapView<Type, Handler> get handlers =>
      UnmodifiableMapView(_handlers);

  /// Adds a handler for the request type [R].
  ///
  /// This [handler] will be registered against the type [R] and executed
  /// whenever a [Request] of that type is dispatched.
  void addHandler<R extends Request>(Handler<R, dynamic> handler) {
    if (_handlers.containsKey(R)) {
      throw AlreadyRegisteredException(R);
    }

    _handlers[R] = handler;
  }

  /// Removes a handler for the request type [R].
  Handler<Request<dynamic>, dynamic> removeHandler<R extends Request>() {
    if (R == Request) {
      throw RequestTypeMissingException();
    }

    _throwIfHandlerMissing(R);

    return _handlers.remove(R)!;
  }

  /// Passes the given [request] to a registered handler and returns a response
  /// of type [Rs].
  Future<Rs> dispatch<Rs>(Request<Rs> request) async {
    _throwIfHandlerMissing(request.runtimeType);

    return await _handlers[request.runtimeType]?.execute(request);
  }

  void _throwIfHandlerMissing(Type requestType) {
    if (_handlers.containsKey(requestType)) {
      return;
    }

    throw MissingHandlerException(requestType);
  }
}
