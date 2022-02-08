import 'dart:async';

import 'package:skiff/skiff.dart';
import 'package:test/test.dart';

import 'helpers/stub_handler.dart';

void main() {
  FuncHandler<StubRequest, RequestResult>? stubRequestHandler;

  late Mediator sut;

  setUp(() {
    stubRequestHandler = FuncHandler<StubRequest, RequestResult>(
        (c) => Future.value(RequestResult.succeeded()));

    sut = Mediator();
  });

  group('Mediator: ', () {
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
  });
}
