import 'dart:async';
import 'dart:collection';

import 'package:skiff/src/bus.dart';
import 'package:skiff/src/event.dart';
import 'package:skiff/src/exceptions.dart';
import 'package:skiff/src/handler.dart';
import 'package:skiff/src/registration.dart';
import 'package:skiff/src/relay.dart';
import 'package:skiff/src/request.dart';
import 'package:skiff/src/stream_registration.dart';

/// Promotes loose coupling between caller and callees by orchestrating the
/// dispatch of [Request] or [Event] objects.
class Mediator implements Bus, Relay {
  final Map<Type, Handler> _handlers = {};
  final StreamController<Event> _events = StreamController.broadcast();

  @override
  UnmodifiableMapView<Type, Handler<Request, dynamic>> get handlers =>
      UnmodifiableMapView(_handlers);

  bool _disposed = false;
  bool get isDisposed => _disposed;

  bool get _canAdd => !isDisposed;

  void dispose() {
    _events.close();
    _disposed = true;
  }

  @override
  Registration listen<E extends Event>(Function(E) fn) {
    _throwBadStateIfDisposed("add listener");
    return StreamRegistration(
        _events.stream.where((e) => e.runtimeType == E).cast<E>().listen(fn));
  }

  @override
  void addHandler<R extends Request>(Handler<R, dynamic> handler) {
    _throwBadStateIfDisposed("add handler");
    if (_handlers.containsKey(R)) {
      throw AlreadyRegisteredException(R);
    }

    _handlers[R] = handler;
  }

  @override
  Handler<Request<dynamic>, dynamic> removeHandler<R extends Request>() {
    _throwBadStateIfDisposed("remove handler");
    if (R == Request) {
      throw RequestTypeMissingException();
    }

    _throwIfHandlerMissing(R);

    return _handlers.remove(R)!;
  }

  @override
  Future<Rs> dispatch<Rs>(Request<Rs> request) async {
    _throwBadStateIfDisposed("dispatch");
    _throwIfHandlerMissing(request.runtimeType);

    return await _handlers[request.runtimeType]?.execute(request);
  }

  @override
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
