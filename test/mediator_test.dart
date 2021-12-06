import 'dart:async';

import 'package:skiff/skiff.dart';
import 'package:test/test.dart';

import 'handler_test.dart';

void main() {
  FuncHandler<StubCommand, RequestResult>? stubCommandHandler;

  Mediator? sut;

  setUp(() {
    stubCommandHandler = FuncHandler<StubCommand, RequestResult>(
        (c) => Future.value(RequestResult.succeeded()));

    sut = Mediator();
  });

  group('Mediator', () {
    group('.addHandler', () {
      test('throws exception if handler already exists', () {
        sut!.addHandler<StubCommand>(stubCommandHandler!);

        const expectedMessage = 'A handler already exists for StubCommand';

        expect(
            () => sut!.addHandler<StubCommand>(stubCommandHandler!),
            throwsA(
              isA<AlreadyRegisteredException>()
                  .having((e) => e.message, 'message', equals(expectedMessage)),
            ));
      });

      test('adds a handler for the given request type', () {
        sut!.addHandler(stubCommandHandler!);
        expect(sut!.handlers.length, 1);
      });
    });

    group('.removeHandler', () {
      test('throws exception if type missing', () {
        const expectedMessage = 'Missing required request type';

        expect(
            () => sut!.removeHandler(),
            throwsA(
              isA<RequestTypeMissingException>()
                  .having((e) => e.message, 'message', equals(expectedMessage)),
            ));
      });

      test('throws exception if handler is missing', () {
        const expectedMessage = 'Handler missing for StubCommand';

        expect(
            () => sut!.removeHandler<StubCommand>(),
            throwsA(
              isA<MissingHandlerException>()
                  .having((e) => e.message, 'message', equals(expectedMessage)),
            ));
      });

      test('removes handler for the given request type', () {
        sut!.addHandler<StubCommand>(stubCommandHandler!);

        var removedHandler = sut!.removeHandler<StubCommand>();

        expect(removedHandler, equals(stubCommandHandler));
        expect(sut!.handlers.length, 0);
      });
    });

    group('.dispatch', () {
      test('throws exception if handler is missing', () {
        const expectedMessage = 'Handler missing for StubCommand';

        var stubCommand = StubCommand('empty', 'empty');

        expect(
            () => sut!.dispatch<RequestResult>(stubCommand),
            throwsA(
              isA<MissingHandlerException>()
                  .having((e) => e.message, 'message', equals(expectedMessage)),
            ));
      });

      test('calls the handler and returns a response', () async {
        sut!.addHandler<StubCommand>(stubCommandHandler!);

        var response = await sut!.dispatch(StubCommand('', ''));

        expect(response.isSuccessful, isTrue);
      });
    });
  });
}
