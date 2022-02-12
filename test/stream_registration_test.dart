import 'dart:async';

import 'package:fake_async/fake_async.dart';
import 'package:mocktail/mocktail.dart';
import 'package:skiff/src/stream_registration.dart';
import 'package:test/test.dart';

import 'helpers/mock_event_callback.dart';

void main() {
  group('StreamRegistration', () {
    test('.dipose should cancel the subscription', () {
      fakeAsync((async) {
        final stream = StreamController<int>();
        final mockEventCallback = MockEventCallback();

        StreamRegistration(stream.stream.listen(mockEventCallback)).dispose();

        stream.add(42);

        async.flushMicrotasks();

        verifyNever(() => mockEventCallback(42));
      });
    });
  });
}
