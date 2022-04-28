import 'package:test/test.dart';

import 'helpers/stub_handler.dart';

void main() {
  StubRequest? stubRequest;
  StubHandler? sut;

  setUp(() {
    stubRequest = StubRequest('jim.hop', 'h0pp3r');
    sut = StubHandler();
  });

  group('StubHandler', () {
    test('.execute() returns successful result', () async {
      var value = await sut!.execute(stubRequest!);

      expect(value.isSuccessful, equals(true));
    });

    test('.execute() returns failed result', () async {
      sut!.fail();

      var value = await sut!.execute(stubRequest!);

      expect(value.isSuccessful, equals(false));
    });
  });
}
