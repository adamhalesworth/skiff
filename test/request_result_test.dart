import 'package:skiff/skiff.dart';
import 'package:test/test.dart';

void main() {
  group('RequestResult', () {
    test('succeeded factory sets successful true', () {
      expect(RequestResult.succeeded().isSuccessful, isTrue);
    });

    test('failed factory sets successful false', () {
      expect(RequestResult.failed().isSuccessful, isFalse);
    });

    test('asFuture returns a completed future', () async {
      var commandFuture =
          await RequestResult.failed(message: 'Something happened').asFuture();

      expect(commandFuture.message, equals('Something happened'));
    });
  });
}
