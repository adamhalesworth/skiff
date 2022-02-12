import 'dart:async';

import 'event.dart';

abstract class Bus {
  /// Returns a [StreamSubscription] listener [fn] that will receive events of type [E].
  ///
  /// To unsubscribe, call `cancel()` on the returned [StreamSubscription].
  StreamSubscription<E> addListener<E extends Event>(Function(E) fn);

  /// Sends [event] to all registered listeners.
  void broadcast<E extends Event>(E event);
}
