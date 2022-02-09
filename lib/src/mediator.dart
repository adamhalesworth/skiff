import 'dart:async';
import 'dart:collection';

import 'event.dart';
import 'exceptions.dart';
import 'handler.dart';
import 'request.dart';

/// Promotes loose coupling between caller and callees.
class Mediator {
  final Map<Type, Handler> _handlers = {};
  final StreamController<Event> _events = StreamController.broadcast();

  /// Gets the currently registered handlers for this [Mediator].
  UnmodifiableMapView<Type, Handler> get handlers =>
      UnmodifiableMapView(_handlers);

  bool _disposed = false;
  bool get isDisposed => _disposed;

  bool get _canAdd => !isDisposed;

  void dispose() {
    _events.close();
    _disposed = true;
  }

  /// Returns a [StreamSubscription] listener [fn] that will receive events of type [E].
  ///
  /// To unsubscribe, call `cancel()`.
  StreamSubscription<E> addListener<E extends Event>(Function(E) fn) {
    _throwBadStateIfDisposed("add listener");
    return _events.stream.where((e) => e.runtimeType == E).cast<E>().listen(fn);
  }

  /// Adds a handler for the request type [R].
  ///
  /// This [handler] will be registered against the type [R] and executed
  /// whenever a [Request] of that type is dispatched.
  void addHandler<R extends Request>(Handler<R, dynamic> handler) {
    _throwBadStateIfDisposed("add handler");
    if (_handlers.containsKey(R)) {
      throw AlreadyRegisteredException(R);
    }

    _handlers[R] = handler;
  }

  /// Removes a handler for the request type [R].
  Handler<Request<dynamic>, dynamic> removeHandler<R extends Request>() {
    _throwBadStateIfDisposed("remove handler");
    if (R == Request) {
      throw RequestTypeMissingException();
    }

    _throwIfHandlerMissing(R);

    return _handlers.remove(R)!;
  }

  /// Passes the given [request] to a registered handler and returns a response
  /// of type [Rs].
  Future<Rs> dispatch<Rs>(Request<Rs> request) async {
    _throwBadStateIfDisposed("dispatch");
    _throwIfHandlerMissing(request.runtimeType);

    return await _handlers[request.runtimeType]?.execute(request);
  }

  /// Sends [event] to all registered listeners.
  void broadcast<E extends Event>(E event) {
    _throwBadStateIfDisposed("broadcast");
    _events.add(event);
  }

  void _throwBadStateIfDisposed(String action) {
    if (_canAdd) return;
    throw StateError("Cannot $action after disposal");
  }

  void _throwIfHandlerMissing(Type requestType) {
    if (_handlers.containsKey(requestType)) return;
    throw MissingHandlerException(requestType);
  }
}
