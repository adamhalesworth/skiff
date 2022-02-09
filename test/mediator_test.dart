import 'dart:async';

import 'package:fake_async/fake_async.dart';
import 'package:mocktail/mocktail.dart';
import 'package:skiff/skiff.dart';
import 'package:test/test.dart';

import 'helpers/mock_event_callback.dart';
import 'helpers/stub_event.dart';
import 'helpers/stub_handler.dart';

void main() {
  FuncHandler<StubRequest, RequestResult>? stubRequestHandler;

  late Mediator sut;

  setUpAll(() {
    registerFallbackValue(StubEvent());
  });

  setUp(() {
    stubRequestHandler = FuncHandler<StubRequest, RequestResult>(
        (c) => Future.value(RequestResult.succeeded()));

    sut = Mediator();
  });

  group('Mediator', () {
    group('.addHandler', () {
      test('throws exception if handler already exists', () {
        sut.addHandler<StubRequest>(stubRequestHandler!);

        const expectedMessage = 'A handler already exists for StubRequest';

        expect(
            () => sut.addHandler<StubRequest>(stubRequestHandler!),
            throwsA(
              isA<AlreadyRegisteredException>()
                  .having((e) => e.message, 'message', equals(expectedMessage)),
            ));
      });

      test('adds a handler for the given request type', () {
        sut.addHandler(stubRequestHandler!);
        expect(sut.handlers.length, 1);
      });
    });

    group('.removeHandler', () {
      test('throws exception if type missing', () {
        const expectedMessage = 'Missing required request type';

        expect(
            () => sut.removeHandler(),
            throwsA(
              isA<RequestTypeMissingException>()
                  .having((e) => e.message, 'message', equals(expectedMessage)),
            ));
      });

      test('throws exception if handler is missing', () {
        const expectedMessage = 'Handler missing for StubRequest';

        expect(
            () => sut.removeHandler<StubRequest>(),
            throwsA(
              isA<MissingHandlerException>()
                  .having((e) => e.message, 'message', equals(expectedMessage)),
            ));
      });

      test('removes handler for the given request type', () {
        sut.addHandler<StubRequest>(stubRequestHandler!);

        var removedHandler = sut.removeHandler<StubRequest>();

        expect(removedHandler, equals(stubRequestHandler));
        expect(sut.handlers.length, 0);
      });
    });

    group('.dispatch', () {
      test('throws exception if handler is missing', () {
        const expectedMessage = 'Handler missing for StubRequest';

        var stubRequest = StubRequest('empty', 'empty');

        expect(
            () => sut.dispatch<RequestResult>(stubRequest),
            throwsA(
              isA<MissingHandlerException>()
                  .having((e) => e.message, 'message', equals(expectedMessage)),
            ));
      });

      test('calls the handler and returns a response', () async {
        sut.addHandler<StubRequest>(stubRequestHandler!);

        var response = await sut.dispatch(StubRequest('', ''));

        expect(response.isSuccessful, isTrue);
      });
    });

    group('.addListener', () {
      test('returns a StreamSubscription', () {
        var listener = sut.addListener((StubEvent e) {});
        expect(listener, isA<StreamSubscription>());
      });

      test('creates a correctly wired-up listener', () {
        final mockListener = MockEventCallback();
        final listener = sut.addListener<StubEvent>(mockListener);

        expect(listener, isA<StreamSubscription<StubEvent>>());
      });
    });

    group('.broadcast', () {
      test('fires the listener', () {
        fakeAsync((async) {
          final mockListener = MockEventCallback();
          sut.addListener<StubEvent>(mockListener);

          sut.broadcast(StubEvent());

          async.flushMicrotasks();

          verify(() => mockListener(any())).called(1);
        });
      });
    });

    group('.dispose', () {
      group('causes a StateError when', () {
        test('adding a listener', () {
          sut.dispose();

          expect(
              () => sut.addListener((e) {}),
              throwsA(isA<StateError>().having((e) => e.message, 'message',
                  "Cannot add listener after disposal")));
        });

        test('adding a handler', () {
          sut.dispose();

          expect(
              () => sut.addHandler(StubHandler()),
              throwsA(isA<StateError>().having((e) => e.message, 'message',
                  "Cannot add handler after disposal")));
        });

        test('removing a handler', () {
          sut.dispose();

          expect(
              () => sut.removeHandler<StubRequest>(),
              throwsA(isA<StateError>().having((e) => e.message, 'message',
                  "Cannot remove handler after disposal")));
        });

        test('dispatching a request', () {
          sut.dispose();

          expect(
              () => sut.dispatch(StubRequest('', '')),
              throwsA(isA<StateError>().having((e) => e.message, 'message',
                  "Cannot dispatch after disposal")));
        });

        test('broadcasting an event', () {
          sut.dispose();

          expect(
              () => sut.broadcast(StubEvent()),
              throwsA(isA<StateError>().having((e) => e.message, 'message',
                  "Cannot broadcast after disposal")));
        });
      });
    });
  });
}
