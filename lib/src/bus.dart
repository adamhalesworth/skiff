import 'package:skiff/src/event.dart';
import 'package:skiff/src/registration.dart';

/// Takes an [Event] and passes it to any registered listeners.
abstract class Bus {
  /// Registers the listener [fn] that will receive events of type [E] and returns
  /// a [Registration].
  ///
  /// To stop listening, call `dispose()` on the returned [Registration].
  Registration listen<E extends Event>(Function(E) fn);

  /// Sends [event] to all registered listeners.
  void broadcast<E extends Event>(E event);
}
