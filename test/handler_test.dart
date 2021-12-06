import 'dart:async';

import 'package:skiff/skiff.dart';
import 'package:test/test.dart';

class StubCommand implements Request<RequestResult> {
  final String username;
  final String password;

  StubCommand(this.username, this.password);

  @override
  String toString() => '$username, ${"*" * password.length}';
}

class StubHandler implements Handler<StubCommand, RequestResult> {
  bool _shouldFail = false;

  void fail() => _shouldFail = true;

  @override
  Future<RequestResult> execute(StubCommand command) {
    return _shouldFail
        ? Future.value(RequestResult.failed(message: 'Something went wrong'))
        : Future.value(RequestResult.succeeded());
  }
}

void main() {
  StubCommand? stubCommand;
  StubHandler? sut;

  setUp(() {
    stubCommand = StubCommand('jim.hop', 'h0pp3r');
    sut = StubHandler();
  });

  group('StubHandler', () {
    test('.execute() returns successful result', () async {
      var value = await sut!.execute(stubCommand!);

      expect(value.isSuccessful, equals(true));
    });

    test('.execute() returns failed result', () async {
      sut!.fail();

      var value = await sut!.execute(stubCommand!);

      expect(value.isSuccessful, equals(false));
    });
  });
}
