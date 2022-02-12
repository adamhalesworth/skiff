import 'dart:async';

import 'package:skiff/src/registration.dart';

/// A [Registration] for the default event bus implementation.
class StreamRegistration implements Registration {
  final StreamSubscription _subscription;

  StreamRegistration(this._subscription);

  @override
  void dispose() {
    _subscription.cancel();
  }
}
